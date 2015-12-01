class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string  :name,  null: false
      t.text    :description, null: false
      t.text    :address, null: false
      t.decimal :latitude, null: false
      t.decimal :longitude, null:false
      t.boolean :is_deleted, null: false, default: false
      t.timestamps null: false
    end
  end
end
