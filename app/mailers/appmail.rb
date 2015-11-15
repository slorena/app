class Appmail < ApplicationMailer
	
	def new_feed(user, title, count)
		@user = user
		@title = title
		@count = count
	    mail(to: @user.email,
	    	 from: "services@mydomain.com",
	    	 subject: "Feed nou",
	    	 content_type: 'text/html'
	    	)
	end

	
	def delete_feed(user, title, count)
		@user = user
		@title = title
		@count = count
	    mail(to: @user.email,
	    	 from: "services@mydomain.com",
	    	 subject: "Feed sters",
	    	 content_type: 'text/html'
	    	)
	end

	def new_product(user, title_feed, title_product)
		@user = user
		@title_feed = title_feed
		@title_product = title_product
	    mail(to: @user.email,
	    	 from: "services@mydomain.com",
	    	 subject: "Produs nou",
	    	 content_type: 'text/html'
	    	)
	end
	def update_product(user, title_feed, title_product)
		@user = user
		@title_feed = title_feed
		@title_product = title_product
	    mail(to: @user.email,
	    	 from: "services@mydomain.com",
	    	 subject: "Produs modificat",
	    	 content_type: 'text/html'
	    	)
	end
	def delete_product(user, title_feed, title_product)
		@user = user
		@title_feed = title_feed
		@title_product = title_product
	    mail(to: @user.email,
	    	 from: "services@mydomain.com",
	    	 subject: "Produs sters",
	    	 content_type: 'text/html'
	    	)
	end

end
