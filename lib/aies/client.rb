require 'uuidtools'
module Aies
  class Client
    attr_reader :name, :uuid
    def initialize name
      @name = name
      @uuid = UUIDTools::UUID.random_create.to_s.gsub("-","")
    end

  end
end
