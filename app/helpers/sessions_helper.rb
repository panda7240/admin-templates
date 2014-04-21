# -*- encoding : utf-8 -*-
module SessionsHelper

  def sign_in(user)
    #cookies[:remember_token] = { value: user.remember_token, expires: 20.years.from_now.utc } cookies20年之后才失效
    #等同于下面一行代码
    cookies[:remember_token] = user.remember_token

    #在视图中可以这样用<%= current_user.name %>
    self.current_user = user

    #User.find_by_remember_token(cookies[:remember_token]) 可以通过它在页面中取到用户对象
  end



  def current_user=(user)
    @current_user = user
  end




  #当且仅当@current_user未定义时才进行赋值,避免重复查询数据库
  #def current_user
  #  @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  #end

  def current_user?(user)
    user == current_user
  end


  def sign_out
    #self.current_user = nil
    #cookies[:remember_token] = nil
  end


  def redirect_back_or(default)
    #如果session[:return_to]地址为空则跳转到默认页面
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  #存储登录之前想访问的地址
  def store_location
    session[:return_to] = request.fullpath
  end



  def signed_in_user
    #等同
    #flash[:notice] = "Please sign in."
    #redirect_to signin_path
    #flash[:error]也可以用这样的简便形式,但是flash[:success]却不行
    unless signed_in?
      #存储想要登录后跳转的地址
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

end
