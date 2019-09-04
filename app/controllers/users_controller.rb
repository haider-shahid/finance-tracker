class UsersController < ApplicationController
  def my_portfolio
    @user = current_user
    @user_stocks = @user.stocks
  end

  def my_friends
    @friendships = current_user.friends
  end

  def show
    @user_to_show = User.find(params[:id])
    @stocks = @user_to_show.stocks
  end

  def search
    if params[:friend_search].present?
      @users = User.search(params[:friend_search])
      if @users
      else
        flash.now[:danger] = "No User Found"
      end
    else
        flash.now[:danger] = "You have entered an empty string!"
    end
    respond_to do |format|
      format.js {render partial: 'users/friend_search_result'}
    end
  end

  def add_friend
    friend = User.find(params[:frind])
    current_user.friendships.build(friend_id: friend.id)

    if current_user.save
      flash[:success] = "#{friend.full_name} is successfully added as your friend."
    else
      flash[:danger] = "Error in adding a friend"
    end
    redirect_to my_friends_path
  end
end
