class FriendsForeignKey < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :friends, :users, column: :user_sender_id
    add_foreign_key :friends, :users, column: :user_receiver_id
  end
end
