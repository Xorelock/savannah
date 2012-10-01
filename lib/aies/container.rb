module Aies
  class Container
    class << self
      def instance
        @instance ||= Server.new
      end
    end
  end
end
