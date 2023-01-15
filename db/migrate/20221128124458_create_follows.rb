class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|

      t.timestamps
      
      t.integer :followed_id
      t.integer :follower_id
      
    end
  end
end
