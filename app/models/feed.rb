require 'open-uri'
require 'uri'
require 'paperclip'
class Feed < ActiveRecord::Base
	has_many :products, :dependent => :destroy

	has_attached_file :file

	attr_accessible :title, :file, :file_file_name

	before_save :parse_file

	def parse_file
		tempfile = file.queued_for_write[:original]
    	doc = Nokogiri::XML(tempfile)
    	parse_xml(doc)
	end

	def parse_xml(doc)
		nodes = doc.xpath('items')

    	nodes.each do |node|
      		parse_feeds(node)
    	end
  	end


  	def parse_feeds(node)

    if node.node_name.eql? 'items'

    	node.elements.each do |node|
		      product = Product.new

		      node.elements.each do |node|
		      	puts node.name
		        product.title = node.text.to_s if node.name.eql? 'title'

		        product.price = node.text if node.name.eql? 'price'

		        product.campaign_name = node.text.to_s if node.name.eql? 'campaign name'
		        product.description = node.text.to_s if node.name.eql? 'description'

		        product.image = URL.parse(node.text).open if node.name.eql? 'image urls'
		       

		      end
		     	self.products << product
		 end
    end
  end

end
