require 'aies'

class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  def obtain_server
    @server ||= Aies::Container.instance
  end

  def render_error status, message=nil
    if message
      render :status => status, :body => message
    else
      head status
    end
  end
end
