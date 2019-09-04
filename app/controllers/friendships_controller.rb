class FriendshipsController < ApplicationController
  def destroy
    friend = User.find(params[:id])
    flash[:danger] = "#{friend.full_name} is Removed from your friend list"
    @friend_to_delete = Friendship.where(user_id: current_user.id ,friend_id: friend.id).first
    @friend_to_delete.destroy
    redirect_to my_friends_path
  end
end