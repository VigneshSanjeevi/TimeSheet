# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end
  
  def facebook      
    @user = UserProvider.find_for_oauth(request.env["omniauth.auth"],session[:sign])
    if @user && session[:sign] == 2
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    elsif session[:sign] == 1
      redirect_to new_user_session_path, notice: 'Sign Up Sucessfully'
    else
      flash[:error] = 'There was a problem signing you in through Facebook. Please register.'
      redirect_to new_user_session_path
    end 
end

def github  
  @user = UserProvider.find_for_oauth(request.env["omniauth.auth"],session[:sign])
  if @user && session[:sign] == 2
    sign_in @user
    redirect_to root_path
    set_flash_message(:notice, :success, kind: 'Github') if is_navigational_format?
  elsif session[:sign] == 1
    redirect_to new_user_session_path, notice: 'Sign Up Sucessfully'
  else
    flash[:error] = 'There was a problem signing you in through Github. Please register.'
    redirect_to new_user_session_path
  end 
end

def google_oauth2
  @user = UserProvider.find_for_oauth(request.env["omniauth.auth"],session[:sign])
  if @user && session[:sign] == 2
    sign_in_and_redirect @user
    set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
  elsif session[:sign] == 1
    redirect_to new_user_session_path, notice: 'Sign Up Sucessfully'
  else
    flash[:error] = 'There was a problem signing you in through Google. Please register.'
    redirect_to new_user_session_path
  end 
end
  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
