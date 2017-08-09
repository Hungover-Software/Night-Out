class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.references :user, foreign_key: true, :null => false
      t.integer :weight

      t.timestamps
    end
  end
end
