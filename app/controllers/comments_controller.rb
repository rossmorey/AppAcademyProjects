class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    parent_post = @comment.post
    @comment.author = current_user
    if @comment.save
      redirect_to post_url(parent_post)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def new
    @comment = Comment.new
    render :new
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end

end
