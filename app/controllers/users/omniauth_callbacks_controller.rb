class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def authorizate
    auth = request.env["omniauth.auth"]
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      puts @user.inspect
      # sign_in_and_redirect @user, :event => :authentication
      sign_in @user
      redirect_to user_path(@user.id)      
      set_flash_message(:notice, :success, :kind => "#{auth.provider}") if is_navigational_format?
    else
      session["devise.data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end  

  def failure
    redirect_to root_path
  end

  alias :facebook :authorizate
  alias :twitter :authorizate
  alias :vkontakte :authorizate
end

