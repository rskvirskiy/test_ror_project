class AddPicPaperclip < ActiveRecord::Migration
 	def up
    	add_column :microposts, :pic_file_name,    :string
     	add_column :microposts, :pic_content_type, :string
     	add_column :microposts, :pic_file_size,    :integer
      	add_column :microposts, :pic_updated_at,   :datetime
    end
 
    def down
     	remove_column :microposts, :pic_file_name
     	remove_column :microposts, :pic_content_type
     	remove_column :microposts, :pic_file_size
     	remove_column :microposts, :pic_updated_at
   	end
end
