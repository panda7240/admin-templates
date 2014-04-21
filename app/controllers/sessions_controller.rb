# -*- encoding : utf-8 -*-
class SessionsController < ApplicationController

  #进入登录页面
  def new
    render 'new',:layout => 'nologin'
  end

  #登录,创建session
  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Sign the user in and redirect to the user's show page.

      sign_in user
      flash[:success] = "Welcome to the Eagleye Admin!"
      #跳转到登录之前想访问的地址
      redirect_back_or user
    else
      # Create an error message and re-render the signin form.
      #flash中的信息是在一个请求的生命周期内持续存在的,
      #而render与redirect不同,不算新的请求,所以需要flash.now来解决信息滞留的情况
      flash.now[:error] = 'Invalid email/password combination'
      # Not quite right!
      render 'new'
    end
  end

  #退出,销毁session
  def destroy
    sign_out user
    redirect_to root_path
  end
end
