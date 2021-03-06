class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.integer :weight
      t.references :user, foreign_key: true, :null => false
      t.references :option, foreign_key: true, :null => false

      t.timestamps
    end
  end
end
