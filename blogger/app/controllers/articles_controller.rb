class ArticlesController < ApplicationController
  before_filter :require_login, except: [:index, :show]
  include ArticlesHelper

  def index
    @articles = Article.all
  end

  def create
    # fail, uncomment to see params upon form submit
    @article = Article.new(article_params)
    @article.author_id = current_user.id
    @article.save

    flash.notice = "Article '#{@article.title}' was created."

    redirect_to article_path(@article)
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def show
    @article = Article.find(params[:id])
    increment_view_count
    @comment = Comment.new
    @comment.article_id = @article.id
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)

    flash.notice = "Article '#{@article.title}' was updated."

    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    flash.notice = "Article '#{@article.title}' was deleted."

    redirect_to articles_path
  end
end
