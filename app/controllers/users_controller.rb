class UsersController < ApplicationController
  def show
    #@topics = current_user.topics
    @bookmarks = current_user.bookmarks
    @liked_bookmarks = Like.where(user_id: current_user.id).to_a
  end
end
