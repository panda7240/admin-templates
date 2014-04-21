# -*- encoding : utf-8 -*-
class ProfileController < ApplicationController
  #before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]

  def edit
    @user = current_user
  end

  def modify
    @user = current_user
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    params[:user].delete(:email)
    if @user.update_attributes(params[:user])
      flash[:success] = "更新成功"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end


end
