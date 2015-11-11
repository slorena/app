class AddPaperclipToFeed < ActiveRecord::Migration
  def change
  	add_attachment :feeds, :file
  end
end
