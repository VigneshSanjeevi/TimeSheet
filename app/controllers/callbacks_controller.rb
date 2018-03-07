class CallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = UserProvider.find_for_oauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication                   
    end
end

def github  
  @user = UserProvider.find_for_oauth(request.env["omniauth.auth"])
  if @user.persisted?
    sign_in_and_redirect @user, :event => :authentication 
  end 
end
def google_oauth2
  @user = UserProvider.find_for_oauth(request.env["omniauth.auth"])
  if @user.persisted?
    sign_in_and_redirect @user, :event => :authentication  
  end
end
end
