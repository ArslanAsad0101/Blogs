class PostsController < ApplicationController
before_action :authenticate_user!
before_action :set_post, only: [:show]
before_action :set_owned_post, only: [:edit, :update, :destroy]
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

def set_owned_post
  @post = current_user.posts.find(params[:id])
end
end