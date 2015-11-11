class AddImageToProduct < ActiveRecord::Migration
  def change
  end

  add_attachment :products, :image  
end
