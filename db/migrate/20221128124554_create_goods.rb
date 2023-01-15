class CreateGoods < ActiveRecord::Migration[6.1]
  def change
    create_table :goods do |t|

      t.timestamps
      
      t.integer :customer_id
      t.integer :post_id
      
    end
  end
end
