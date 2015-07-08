class TopicsController < ApplicationController
  def index
    if current_user
      @topics = current_user.topics
    end
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end
  
  def create
    @topic = current_user.topics.new(topic_params)
    if @topic.save
      redirect_to @topic, notice: "Topic was saved successfully."
    else
      flash[:error] = "Error saving topic, please try again"
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end
  
  def update
    @topic = Topic.find(params[:id])
    if @topic.update_attributes(topic_params)
      redirect_to @topic, notice: "Topic was updtaed"
    else
      flash[:error] = "Error editing topic, please try again"
      render :edit
    end
  end
  
  def destroy
    @topic = Topic.find(params[:topic_id])
    if @topic.destroy
      flash[:notice] = "\"#{@topic.title}\" was deleted."
      redirect_to topics_path
    else
      flash[:error] = "Error deleting topic"
      render :show
    end
  end
  
  private
  def topic_params
    params.require(:topic).permit(:title)
  end
end
