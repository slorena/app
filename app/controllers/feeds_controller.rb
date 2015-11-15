class FeedsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :js

  handles_sortable_columns

  def new
    @feed = Feed.new
  end


  def create
    @feed = current_user.feeds.new(feed_params)
    count = @feed.products.count
      if @feed.save
        Appmail.new_feed(current_user, @feed.title, count).deliver
        redirect_to @feed,  success: 'Un nou feed a fost creat.' 
      else
        render 'new'
      end
  end


  def show
    @feed = current_user.feeds.find(params[:id])
    order = sortable_column_order
    @products = @feed.products.order(order).paginate(page: params[:page], per_page: 5)
  end

  def index
    @feeds = current_user.feeds.order(created_at: :desc)
  end

  def destroy
    @feed = current_user.feeds.find(params[:id])
    count = @feed.products.count

    Appmail.delete_feed(current_user, @feed.title, count).deliver

    @feed.destroy
    respond_to do |format|
      format.html { redirect_to feeds_url, danger: 'Un feed a fost sters.' }
    end
  end

  private
  def feed_params
    params.require(:feed).permit(:title, :file, :file_file_name)
  end

end
