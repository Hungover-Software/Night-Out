class CreateOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :options do |t|
      t.string :name, :null => false
      t.references :user, foreign_key: true, :null => false
      t.references :poll, foreign_key: true, :null => false

      t.timestamps
    end
  end
end
