class SessionsController < ApplicationController
  require 'securerandom'

  def new
    # renderöi kirjautumissivun
  end

  def create
    user = User.find_by username: params[:username]
    if user && user.authenticate(params[:password]) && !user.frozen_account
      session[:user_id] = user.id
      redirect_to user_path(user), notice: "Welcome back!"
    elsif user.frozen_account?
      redirect_to :back, notice:"Account frozen"
    else
      redirect_to :back, notice: "Username and/or password mismatch"
    end
  end

  def create_oauth
    user = User.find_by username: env["omniauth.auth"].info.nickname
    if user
      session[:user_id] = user.id
      redirect_to user_path(user), notice: "Welcome back!"
    else 
      random_string = SecureRandom.hex
      @user = User.new username: env["omniauth.auth"].info.nickname, password: random_string, password_confirmation: random_string
      @user.update_attribute(:admin, false)  
      @user.save
      redirect_to user_path(@user), notice: "Welcome"
    end
  end  

  def destroy
    # nollataan sessio
    session[:user_id] = nil
    # uudelleenohjataan sovellus pääsivulle
    redirect_to :root
  end
end