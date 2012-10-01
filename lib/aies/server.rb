module Aies
  class Server
    def initialize
      @clients = {}
      @clients_by_name = {}
    end
    def add_client name
      return nil if @clients_by_name.include?(name)
      client = Client.new(name)
      @clients[client.uuid] = client
      @clients_by_name[name] = client.uuid
      client
    end
    def get_clients
      clone = @clients.clone
      clone.freeze
      clone
    end
    def sense client, sensor_type
      return nil unless @clients.include?(client.uuid)
      return ( @clients.map { |k,v| v.uuid } ).join(",");
    end
    def act client, actuator_type
      return nil unless @clients.include?(client.uuid)
      return []
    end
  end

end
