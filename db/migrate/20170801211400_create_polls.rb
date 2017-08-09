class CreatePolls < ActiveRecord::Migration[5.1]
  def change
    create_table :polls do |t|
      t.string :name, :null => false
      t.references :event, foreign_key: true, :null => false

      t.timestamps
    end
  end
end
