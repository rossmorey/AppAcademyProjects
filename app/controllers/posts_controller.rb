class PostsController < ApplicationController

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    # @post.sub_id =
    if @post.save
      redirect_to root_url
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def new
    @post = Post.new
    render :new
  end

  def show
    @post = Post.find_by_id(params[:id])
    @author = @post.author
    render :show
  end

  def edit
    @post = Post.find_by_id(params[:id])
    render :edit
  end

  def update
    @post = Post.find_by_id(params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Post.find_by_id(params[:id])
    current_sub = @post.subs
    @post.destroy
    redirect_to subs_url(current_sub)
  end


  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [] )
  end

end
