class CreatePolls < ActiveRecord::Migration[5.1]
  def change
    create_table :polls do |t|
      t.string :name, :null => false
      t.references :option, foreign_key: true

      t.timestamps
    end
  end
end
