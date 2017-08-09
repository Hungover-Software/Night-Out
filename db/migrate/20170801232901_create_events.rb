class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name, :null => false
      t.references :user, foreign_key: true, :null => false
      t.date :date, :null => false
      t.time :time, :null => false
      t.references :event_invite, foreign_key: true
      t.references :comment, foreign_key: true
      t.references :poll, foreign_key: true

      t.timestamps
    end
  end
end
