class ProductsController < ApplicationController

  before_filter :authenticate_user!
  skip_filter :verify_authenticity_token, :create
  respond_to :js, :html, :json


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
        format.html {redirect_to feed_path(@feed), success: 'Un nou produs a fost adaugat.' }
        format.js {}
      end
    else
      render "new"
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
      redirect_to feed_path(@feed), info: 'Un produs a fost modificat.' 
    else
      render "edit" 
    end
  end

  def destroy
    @feed = Feed.find(params[:feed_id])
    @product = @feed.products.find(params[:id])
    Appmail.delete_product(current_user, @feed.title, @product.title).deliver
    @product.destroy
    redirect_to feed_path(@feed), danger: 'Un produs a fost sters.' 
  end

  def search
    if(params[:search] and params[:search_by])
      column_name = params[:search_by].to_s + " LIKE ?"
      @products =  Product.where(column_name, "%#{params[:search]}%").paginate(page: params[:page], per_page: 5)
    else
      @products = Product.all.paginate(page: params[:page], per_page: 5)
    end
  end

  private
  def product_params
    params.require(:product).permit(:title, :price, :campaign, :image, :description,:feed_id)
  end

end
