# frozen_string_literal: true

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
    # action that handles the second page for Task 2.3


    # connect to Task 2.4
    @top_articles = [
      { title: 'Breaking News: Important Event', link: 'https://example.com/news1', description: 'A description of the breaking news.' },
      { title: 'Tech Innovations: Latest Gadgets Revealed', link: 'https://example.com/news2', description: 'Explore the cutting-edge tech unveiled recently.' },
      { title: 'Health and Wellness: Tips for a Healthy Lifestyle', link: 'https://example.com/news3', description: 'Discover ways to maintain a healthy lifestyle.' },
      { title: 'Entertainment Buzz: Celebrity Gossip and Updates', link: 'https://example.com/news4', description: 'Get the latest scoop on your favorite celebrities.' },
      { title: 'Sports Highlights: Exciting Moments from the Games', link: 'https://example.com/news5', description: 'Relive the thrilling moments from recent sports events.' }
    ]
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
end
