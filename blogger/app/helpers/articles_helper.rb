module ArticlesHelper
  def article_params
    params.require(:article).permit(:title, :body, :tag_list, :image)
  end

  def increment_view_count
    @article.view_count += 1
    @article.save
  end
end
