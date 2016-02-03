class FriendshipsController < ApplicationController

  def destroy
    @friendship = current_user.friendships.where(friend_id: params[:id]).first
    if @friendship
      if @friendship.destroy
        flash[:success] = "No longer friends with #{@friendship.friend.full_name}"
        redirect_to my_friends_path
      else
        flash[:danger] = "Something went wrong"
        redirect_to my_friends_path
      end
    else
      flash[:warning] = 'You guys are no friends yet'
      redirect_to my_friends_path
    end
  end

end