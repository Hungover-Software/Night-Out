class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.integer :users

      t.timestamps
    end
  end
end
