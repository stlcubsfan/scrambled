class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def index
    render text: "Hello, Ray!"
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitzer.for(:sign_up) << :name
  end
end
