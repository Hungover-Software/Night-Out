class CreateFriends < ActiveRecord::Migration[5.1]
  def change
    create_table :friends do |t|
      t.references "user_sender", references: :users, :null => false
      t.references "user_receiver", references: :users, :null => false
      
      t.boolean "accepted", :null => false

      t.timestamps
    end
  end
end
