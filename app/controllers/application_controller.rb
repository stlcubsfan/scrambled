class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :password, :password_confirmation, :first_name, :last_name) }
  end

  def open_invitations
    if user_signed_in?
       if current_user.tournament_invitations.unaccepted.size > 0
         flash[:unaccepted_invitations] = "You have an invitation waiting.  Click here to accept."
       end
    end
  end

end
