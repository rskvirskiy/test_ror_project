class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    auth = request.env["omniauth.auth"]
    if @user=User.find_by_login(auth[:info][:nickname]) #if we have this user
      sign_in @user
    else #if we don't have, we'll create this user
      @user = User.new(login: auth[:info][:nickname].to_s, fullname: auth[:info][:name].to_s, email: auth[:info][:nickname].to_s + "@test.com", password: "foobar", password_confirmation: "foobar" );
      if @user.save
        sign_in @user
      else
        flash[:error]="Unknown error with authentication"
        redirect_to '/signin'
      end
    end
      current_user.authentications.find_or_create_by_provider_and_uid(auth[:provider], auth[:uid])
      flash[:notice] = "Authentication successfull"
      redirect_to @user
  end

  def destroy
    @authentication = current_user.authentication.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end
end
