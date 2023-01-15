class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|

      t.timestamps

      t.references :customer, foreign_key: true
      t.references :post, foreign_key: true
      t.text :comment

    end
  end
end
