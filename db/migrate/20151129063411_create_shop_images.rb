class CreateShopImages < ActiveRecord::Migration
  def change
    create_table :shop_images do |t|
      t.integer   :shop_id, null: false
      t.string    :image_file_name, null: false
      t.string    :image_content_type, null: false
      t.integer   :image_file_size, null: false 
      t.timestamps
    end
  end
end
