class TagsController < ApplicationController
  before_filter :require_login, only: [:destroy]
  def index
    @tags = Tag.all.sort_by { |tag| tag.name }
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    flash.notice = "The #{@tag.name} tag was deleted."

    redirect_to tags_path
  end
end
