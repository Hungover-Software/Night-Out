class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.date :date
      t.time :time
      t.references :event_invite, foreign_key: true
      t.references :comment, foreign_key: true
      t.references :poll, foreign_key: true

      t.timestamps
    end
  end
end
