class FeedsController < ApplicationController
	before_filter :authenticate_user!


	def new
	  @feed = Feed.new
	end
	 
	def edit
	  @feed = Feed.find(params[:id])
	end
	 
	def create
	  feed = Feed.new(feed_params)

	  if feed.save
	    redirect_to feed
	  else
	    render 'new'
	  end
	end


	def show
    	@feed = Feed.find(params[:id])
  	end

  	def index
  		@feeds = Feed.order(created_at: :desc)
  	end

	private
	def feed_params
		params.require(:feed).permit(:title, :file, :file_file_name)
	end

end
