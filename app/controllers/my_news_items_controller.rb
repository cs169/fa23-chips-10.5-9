# frozen_string_literal: true

require 'news-api'

class MyNewsItemsController < SessionController
  before_action :set_representative
  before_action :set_representatives_list
  before_action :set_issues_list
  before_action :set_selected_rep_and_issue, only: %i[list create update]
  before_action :set_news_item, only: %i[edit update destroy]

  def new
    @news_item = NewsItem.new
  end

  def edit; end

  def create
    Rails.logger.debug news_item_params
    @news_item = NewsItem.new(news_item_params)
    if @news_item.save
      redirect_to representative_news_item_path(@selected_representative, @news_item),
                  notice: 'News item was successfully created.'
    else
      render :new, error: 'An error occurred when creating the news item.'
    end
  end

  def update
    if @news_item.update(news_item_params)
      redirect_to representative_news_item_path(@selected_representative, @news_item),
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

  # a term prependended with + indicates that it MUST appear in the results
  # using AND ensures articles of the represntative AND the issue appear
  # REF: https://newsapi.org/docs/endpoints/everything
  # using .get_everything method
  # REF: https://github.com/olegmikhnovich/News-API-ruby/blob/master/README.md

  def list
    initialize_api
    query_string = "+#{@selected_representative.name} AND +#{@selected_issue}"
    page_size = '5'
    response = @news_api.get_everything(q: query_string, page_size: page_size)
    (return if response == [])
    @news_items = []
    num_items = 0
    response.each do |article|
      (next unless num_items <= 5)
      title = article.title
      description = article.description
      link = article.url
      news_item = NewsItem.new(title: title, description: description, link: link,
                               issue: @selected_issue, representative_id: @selected_representative_id)
      @news_items.push(news_item)
      num_items += 1
    end
  end

  private

  def set_representative
    @representative = Representative.find(params[:representative_id])
  end

  def set_representatives_list
    @representatives_list = Representative.all.map { |r| [r.name, r.id] }
  end

  def set_news_item
    @news_item = NewsItem.find(params[:id])
  end

  def set_selected_rep_and_issue
    if params[:news_item][:representative_id].present?
      @selected_representative = Representative.find(params[:news_item][:representative_id])
      @selected_representative_id = params[:news_item][:representative_id]
      @selected_issue = params[:news_item][:issue]
    else
      @selected_issue = nil
      @selected_representative = nil
      @selected_representative_id = nil
      redirect_to representative_news_items_path(@representative), notice: 'Please fill in all fields'
    end
  end

  def set_issues_list
    @issues_list = NewsItem::ISSUES_LIST
  end

  # Only allow a list of trusted parameters through.
  def news_item_params
    params.permit(:title, :description, :link,
                  :issue, news_item: %i[representative_id ratings])
    { title: params[:title], description: params[:description], link: params[:link],
                    issue: params[:issue], representative_id: params[:news_item][:representative_id] }
  end

  def initialize_api
    api_key = Rails.application.credentials[:NEWS_API_KEY]
    @news_api = News.new(api_key)
  end
end
