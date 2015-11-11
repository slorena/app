class Product < ActiveRecord::Base
	attr_accessible :feed_id, :title, :price, :campaign, :description, :image
	belongs_to :feeds
	has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" }
end
