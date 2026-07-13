class PostsController < ApplicationController
before_action :authenticate_user!
before_action :set_post, only: [:show]
before_action :set_editable_post, only: [:edit, :update, :destroy]
before_action :authorize_post_creation, only: [:new, :create]


    # Index page where all the post will be displayed
    def index
        @posts = Post.all
        # @posts = current_user.posts
    end
    
    
    # Page where user can crerate a new posts
    def new 
        @post = Post.new
    end 
    
    def create 
        @post = current_user.posts.build(post_params)

  if @post.save
    redirect_to @post, notice: "Post was successfuly created"
  else
    render :new, status: :unprocessable_entity
  end
    end


   # page where user can view their posts
   def show 
    @comment = Comment.new
   end 



    # page where user can edit their posts
    def edit
    end

    def update 
        if @post.update(post_params)
         redirect_to @post, notice: "Post was successfully updated"    
        else
      render :edit, status: :unprocessable_entity
    end
    end



    # page where user can delete their postrs
    def destroy
         @post.destroy
    redirect_to posts_path, notice: "Post was successfully deleted"
    end



private 

def post_params
    params.require(:post).permit(:title, :body)
end

def set_post
  @post = Post.find(params[:id])
end

def set_editable_post
  @post = Post.find(params[:id])

  unless current_user.admin? || @post.user == current_user
    redirect_to posts_path, alert: "You are not allowed to perform this action."
  end
end

def authorize_post_creation
    unless current_user.author? || current_user.admin?
      redirect_to posts_path, alert: "You are not allowed to create posts."
    end
  end
end