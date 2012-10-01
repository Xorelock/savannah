require 'net/http'
module Aies
  class Agent
    attr_accessor :name, :uuid
    def initialize name, server
      puts name
      puts server
      @name = name
      me = ClientResource.new(:name => name)

      begin
        me.save
        return me
      rescue ActiveResource::ResourceConflict => e
        if e.response.code_type == Net::HTTPConflict
          existing = ClientResource.find(:all)
          existing.each do |item|
            if item.name == @name
              me = ClientResource.find(item.uuid)
              return me
            end
          end
          return nil
        end
      end
    end

    class ClientResource < ActiveResource::Base
      self.site = 'http://localhost:3030/'
      self.element_name = 'client'
    end
  end
end