class ProductsController < ApplicationController
	before_filter :authenticate_user!
 	respond_to :js, :html


	def create
    	@feed = Feed.find(params[:feed_id])
    	@product = @feed.products.build(product_params)
    	
     if @product.save
       respond_to do |format|
        format.html {redirect_to feed_path(@feed)}
        format.js {}
        end
    else
     
       respond_to do |format|
         format.html { redirect_to feed_path(@feed) }
         format.js   { render action: 'failed_create' }
       end
    end
      
  end
 
  private
    def product_params
      params.require(:product).permit(:title, :price)
    end

end
