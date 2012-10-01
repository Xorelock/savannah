class SensorsController < ApplicationController
  before_filter :obtain_server
  before_filter :obtain_client
  def show
    sensor_type = params[:id]
    result = @server.sense(@client, sensor_type)
    if result
      render :json => [ result ]
    else
      head :not_found
    end
  end

  protected
  def obtain_client
    @client = @server.get_clients[params[:client_id]]
    unless @client
      head :not_found
      return
    end
  end
end
