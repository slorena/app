class ProductsController < ApplicationController
	before_filter :authenticate_user!
	
end
