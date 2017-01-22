class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  respond_to :json

  def index
    render 'application/index'
  end
end
