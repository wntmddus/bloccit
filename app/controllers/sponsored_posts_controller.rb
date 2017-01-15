class SponsoredPostsController < ApplicationController
  before_action :find_sponsored_post,
                only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @sponsored_post = SponsoredPost.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @sponsored_post = @topic.posts.build(post_params)
    @sponsored_post.user = current_user

 # #10
    if @sponsored_post.save
 # #11
      flash[:notice] = "Sponsored Post was saved."
      redirect_to [@topic, @sponsored_post]
    else
 # #12
      flash.now[:alert] = "There was an error saving the sponsored post. Please try again."
      render :new
    end
  end


  def edit
  end

  def destroy
  end

  def update
  end

  private

  def find_sponsored_post
    @sponsored_post = SponsoredPost.find(params[:id])
  end
end
