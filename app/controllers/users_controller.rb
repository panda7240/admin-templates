# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  #before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  #before_filter :correct_user, only: [:edit, :update]
  #before_filter :admin_user, only: :destroy
  after_filter :refersh_cache, only: [:create, :update,:destroy]

  def new
    @user = User.new
    render 'new',:layout => 'nologin'
  end


  def create
    #等同于@user = User.new(name: "Foo Bar", email: "foo@invalid", password: "foo", password confirmation: "bar")
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "注册用户成功!"
      redirect_to users_path
    else
      render 'new'
    end
  end

  #访问用户列表
  def index
    @users = User.paginate(page: params[:page])
  end



  def show
    @user = User.find(params[:id])
  end


  def edit
    #在过滤器correct_user中已经定义了@user所以不需要再定义了
    @user = User.find(params[:id])
  end


  def update
    @user = User.find(params[:id])
    if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    if @user.update_attributes(params[:user])
      flash[:success] = "更新成功"
      #sign_in @user
      redirect_to users_path
    else
      render 'edit'
    end
  end


  def destroy
    user = User.find(params[:id])
    if !user.admin?
      user.destroy
      flash[:success] = "User destroyed."
    else
      flash[:error] = "Could not be destroyed."
    end

    redirect_to users_path
  end




  private


    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end


end
