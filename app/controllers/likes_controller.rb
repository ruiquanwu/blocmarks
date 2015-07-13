class LikesController < ApplicationController
  def new 
  end
  
    def create
     @bookmark = Bookmark.find(params[:bookmark_id])
     like = current_user.likes.build(bookmark: @bookmark)
 
     if like.save
       redirect_to [@bookmark.topic, @bookmark], notice: "bookmark was liked."
     else
       redirect_to [@bookmark.topic, @bookmark], notice: "error, please try again."
     end
   end

   def destroy
     @bookmark = Bookmark.find(params[:bookmark_id])
     like = current_user.liked(@bookmark)
 
     if like.destroy
       redirect_to [@bookmark.topic, @bookmark], notice: "bookmark was unliked."
     else
       redirect_to [@bookmark.topic, @bookmark], notice: "error, please try again."
     end
   end
end
