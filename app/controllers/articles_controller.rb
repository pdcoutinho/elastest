class ArticlesController < ApplicationController

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = 1
    @article.status = 0
    if @article.save
      redirect_to search_path
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)
    if @article.save
      redirect_to search_path
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end
end