class ClientsController < ApplicationController
  before_filter :obtain_server
  def index
    render :json => @server.get_clients.map {|k,v| v }
  end
  def create
    return render_error(400) unless params[:client]
    client_info = params[:client]
    client = @server.add_client(client_info[:name])
    return render_error(:conflict) unless client
    render :json => client
  end
  def show
    client = @server.get_clients[params[:id]]
    if client
      render :json => client
    else
      head :not_found
    end
  end
end
