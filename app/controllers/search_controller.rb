class SearchController < ApplicationController
  def search
    if params[:q].nil?
      @articles = Article.__elasticsearch__.search('*')
    else
      @articles = Article.__elasticsearch__.search params[:q]
    end
  end
end