# frozen_string_literal: true

require 'news-api'

class MyNewsItemsController < SessionController
  before_action :set_representative
  before_action :set_representatives_list
  before_action :set_issues_list
  before_action :set_selected_rep_and_issue, only: %i[list]
  before_action :set_news_item, only: %i[edit update destroy]

  def new
    @news_item = NewsItem.new
  end

  def edit; end

  def create
    p news_item_params
    @news_item = NewsItem.new(news_item_params)
    if @news_item.save
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully created.'
    else
      render :new, error: 'An error occurred when creating the news item.'
    end
  end

  def update
    if @news_item.update(news_item_params)
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully updated.'
    else
      render :edit, error: 'An error occurred when updating the news item.'
    end
  end

  def destroy
    @news_item.destroy
    redirect_to representative_news_items_path(@representative),
                notice: 'News was successfully destroyed.'
  end

  def list 
    initialize_api()
    # a term prependended with + indicates that it MUST appear in the results
    # using AND ensures articles of the represntative AND the issue appear
    # REF: https://newsapi.org/docs/endpoints/everything
    query_string = "+#{@selected_representative} AND +#{@selected_issue}"
    # limits number of results per page to 5, default is to show 1 page
    page_size = "5" 
    # use .get_everything. REF: https://github.com/olegmikhnovich/News-API-ruby/blob/master/README.md
    response = @news_api.get_everything(q: query_string, page_size: page_size)
    if response == []
      # handle no news articles case 
      render :list, error: 'No news articles found for this representative.'
    else 
      @news_items = Array.new 
      num_items = 0
      response.each do |article|
        # enforce five item limit here
        if num_items <= 5
          title = article.title
          description = article.description
          link = article.url 
          representative_id = params[:news_item][:representative_id]
          news_item = NewsItem.new(title: title, description: description, link: link, issue: @selected_issue, representative_id: representative_id)
          @news_items.push(news_item)
          num_items += 1 
        else 
          next 
        end 
      end 

    end 
  end 

  private

  def set_representative
    @representative = Representative.find(
      params[:representative_id]
    )
  end

  def set_representatives_list
    @representatives_list = Representative.all.map { |r| [r.name, r.id] }
  end

  def set_news_item
    @news_item = NewsItem.find(params[:id])
  end

  def set_selected_rep_and_issue
    if params[:news_item].present?
      @selected_representative = Representative.find_by(id: params[:news_item][:representative_id])&.name
      @selected_issue = params[:news_item][:issue]

      # Store in session
      session[:selected_representative] = @selected_representative
      session[:selected_issue] = @selected_issue

    else
      # Retrieve from session
      @selected_representative = session[:selected_representative]
      @selected_issue = session[:selected_issue]
    end
  end

  def set_issues_list
    @issues_list = NewsItem::ISSUES_LIST
  end

  # Only allow a list of trusted parameters through.
  def news_item_params
    params.require(:news_item).permit(:news, :title, :description, :link, :representative_id,
                                      :issue, :ratings)
  end

  def initialize_api
    api_key = Rails.application.credentials[:NEWS_API_KEY]
    @news_api = News.new(api_key)
  end 
end
