class IncomingController < ApplicationController

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    # Take a look at these in your server logs
    # to get a sense of what you're dealing with.
    puts "INCOMING PARAMS HERE: #{params}"

    # You put the message-splitting and business
    # magic here. 
    
    # Find the user by using params[:sender]
    sender = params[:sender]
     # Find the topic by using params[:subject]
    subject = params[:subject]
     # Assign the url to a variable after retreiving it from params["body-plain"]
    url = params["body-plain"]

     # Check if user is nil, if so, create and save a new user
    @user = User.where(email: sender).first
    unless @user
      @user = User.new(email: sender, password: "helloworld")
      @user.skip_confirmation!
      @user.save
    end
     # Check if the topic is nil, if so, create and save a new topic
    @topic = Topic.where(title: subject).first
    if @topic
      
    else
      @topic = Topic.new(title: subject, user:@user)
    end
     # Now that you're sure you have a valid user and topic, build and save a new bookmark
    @bookmark = Bookmark.new(url: url, topic: @topic)
    @bookmark.save
    # Assuming all went well. 
    head 200
  end
end