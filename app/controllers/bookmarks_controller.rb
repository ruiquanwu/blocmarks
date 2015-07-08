class BookmarksController < ApplicationController
  def show
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.new
  end
  
  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.build(bookmark_params)
    if @bookmark.save
      redirect_to [@topic, @bookmark], notice: "bookmark was saved successfully."
    else
      flash[:error] = "Error saving topic, please try again"
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
  end
  
  def update
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
    if @bookmark.update_attributes(bookmark_params)
      redirect_to [@topic, @bookmark], notice: "bookmark edit successfully"
    else
      flash[:error] = "Error editing bookmark, please try again"
      render :edit
    end
  end
  
  def destroy
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
    if @bookmark.destroy
      flash[:notice] = "\"#{@topic.title}\" was deleted."
      redirect_to topics_path
    else
      flash[:error] = "Error deleting topic"
      render :show
    end
  end
  
  private
  
  def bookmark_params
    params.require(:bookmark).permit(:url)
  end
end
