class CreateEventInvites < ActiveRecord::Migration[5.1]
  def change
    create_table :event_invites do |t|
      t.references :user, foreign_key: true, :null => false
      t.boolean :status, :null => false

      t.timestamps
    end
  end
end
