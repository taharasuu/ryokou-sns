class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.timestamps

      t.integer :customer_id
      t.integer :genre_id
      t.string :shop
      t.string :postal_code
      t.string :address
      t.float :latitude
      t.float :longitude
      t.integer :evaluation

    end
  end
end
