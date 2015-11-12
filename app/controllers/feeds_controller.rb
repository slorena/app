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

	def update
	  @feed = Feed.find(params[:id])
	 
	  respond_to do |format|
	    if @feed.update_attributes(params[:feed])
	      format.html  { redirect_to(@feed,
	                    :notice => 'feed was successfully updated.') }
	      format.json  { head :no_content }
	    else
	      format.html  { render :action => "edit" }
	      format.json  { render :json => @feed.errors,
	                    :status => :unprocessable_entity }
	    end
	  end
	end


	def show
    	@feed = Feed.find(params[:id])
  	end

  	def index
  		@feeds = Feed.order(created_at: :desc)
  	end

	def destroy
	  @feed = Feed.find(params[:id])
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
