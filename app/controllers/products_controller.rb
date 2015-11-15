class ProductsController < ApplicationController

	before_filter :authenticate_user!
	skip_filter :verify_authenticity_token, :create
 	respond_to :js, :html


 	def new
 		@feed = Feed.find(params[:feed_id])
 		@product = @feed.products.build
 	end

	def create
		@feed = Feed.find(params[:feed_id])
    @product = @feed.products.build(product_params)

    

     if @product.save
     	 Appmail.new_product(current_user, @feed.title, @product.title).deliver
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

	def edit
		@feed = Feed.find(params[:feed_id])
		@product = Product.find(params[:id])
	end

	def update
		@feed = Feed.find(params[:feed_id])
		@product = Product.find(params[:id])
	
			if @product.update(product_params)
				 Appmail.update_product(current_user, @feed.title, @product.title).deliver
				 redirect_to feed_path(@feed)
			else
				render "edit" 
			
		end
	end

	def destroy
    @feed = Feed.find(params[:feed_id])
    @product = @feed.products.find(params[:id])
    Appmail.delete_product(current_user, @feed.title, @product.title).deliver
    @product.destroy
    redirect_to feed_path(@feed)
  end

 
  private
    def product_params
      params.require(:product).permit(:title, :price, :campaign, :image, :description,:feed_id)
    end

end
