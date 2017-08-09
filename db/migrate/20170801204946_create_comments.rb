class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :message, :null => false
      t.timestamp :timestamp, :null => false
      t.references :user, foreign_key: true, :null => false
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
