class UserSessionsController < ApplicationController
  before_filter :require_no_logined, :except => :destroy

  def new
    store_location request.referrer if request.referrer.present?
  end

  def create
    login = params[:login].downcase
    user = User.where("lower(name)=? or lower(email)=?", login, login).first
    if user and user.authenticate(params[:password])
      login_as user
      remember_me if params[:remember_me]
      redirect_back_or_default root_url
    else
      flash[:error] = 'Wrong login name or password'
      redirect_to login_url
    end
  end

  def destroy
    logout
    redirect_to request.referrer || root_url
  end
end
