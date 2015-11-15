class FeedsController < ApplicationController
	before_filter :authenticate_user!
	respond_to :js

	def new
	  @feed = Feed.new

	end
	 
	 
	def create
	  feed = current_user.feeds.new(feed_params)
	  count = feed.products.count
	  if feed.save
       	Appmail.new_feed(current_user, feed.title, count).deliver
	    redirect_to feed
	  else
	    render 'new'
	  end
	end




	def show
    	@feed = Feed.find(params[:id])
     	@product = @feed.products.build
  	end

  	def index
  		@feeds = Feed.order(created_at: :desc)
  	end

	def destroy
	  @feed = Feed.find(params[:id])
	  count = @feed.products.count

	  Appmail.delete_feed(current_user, @feed.title, count).deliver

	  @feed.destroy
	  respond_to do |format|
	    format.html { redirect_to feeds_url }
	    format.json { head :no_content }
	  end
	end

	private
	def feed_params
		params.require(:feed).permit(:title, :file, :file_file_name)
	end

end
