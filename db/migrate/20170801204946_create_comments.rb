class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :message
      t.timestamp :timestamp
      t.integer :commentator

      t.timestamps
    end
  end
end
