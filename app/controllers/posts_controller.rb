class PostsController < ApplicationController
  before_action :require_sign_in, except: :show
  #before_action :authorize_mod_or_admin_or_user, only: [:show, :new, :create, :update]
  #before_action :authorize_admin_or_user, only: [:show, :new, :create, :update, :destroy]
  def show
    @post = Post.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.new

  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(post_params)
    @post.user = current_user

 # #10
    if @post.save
 # #11
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
 # #12
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
     @post = Post.find(params[:id])
     @post.assign_attributes(post_params)

     if @post.save
       flash[:notice] = "Post was updated."
       redirect_to [@post.topic, @post]
     else
       flash.now[:alert] = "There was an error saving the post. Please try again."
       render :edit
     end
   end
   def destroy
     @post = Post.find(params[:id])
     if @post.destroy
       flash[:notice] = "\"#{@post.title}\" was deleted successfully."
       redirect_to @post.topic
     else
       flash.now[:alert] = "There was an error deleting the post."
       render :show
     end
   end
   private

   def post_params
     params.require(:post).permit(:title, :body)
   end
   def authorize_admin_or_user
     @post = Post.find(params[:id])
     unless current_user == @post.user || current_user.admin?
       flash[:alert] = "You must be an admin or owner to do that."
       redirect_to [@post.topic, @post]
     end
   end
   def authorize_mod_or_admin_or_user
     post = Post.find(params[:id])
     unless current_user.moderator? || current_user.admin? || current_user == post.user
       flash[:alert] = "You must be an moderator, admin, or owner to do that."
       redirect_to [post.topic, post]
     end
   end

end
