class CreateFriends < ActiveRecord::Migration[5.1]
  def change
    create_table :friends do |t|
      t.integer "user_sender_id", :null => false
      t.integer "user_receiver_id", :null => false
      
      t.boolean "accepted", :null => false

      t.timestamps
    end
  end
end
