class UsersController < ApplicationController
  def my_portfolio
    @user_stocks = current_user.stocks
    @user       = current_user
  end

  def my_friends
    @user = User.find(4)
    @friendships = @user.friends
  end

  def add_friend
    friend = User.find(params[:id])
    current_user.friends << friend
    flash[:success] = 'Friend added'
    redirect_to my_friends_path
  end

  def show
    @user = User.find(params[:id])
  end

  def search
    puts "====== HERE"
    puts params[:search_param]
    @users = User.search(params[:search_param])
    puts "RESULTS"
    puts @users
    if @users 
      @users = @users.reject { |u| u.id == current_user.id }
      render partial: 'friends/lookup'
    else
      render status: :not_found, nothing: true
    end
  end

  def unfriend
    fs = current_user.friendships
    puts "ID: " + params[:id]
    fs.each do |f|
        if f.friend_id == params[:id]
          f.destroy
          redirect_to my_friends_path
        end
    end
    flash[:dange] = 'something went wrong...'
    redirect_to my_friends_path
  end

end