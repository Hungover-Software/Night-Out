class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.column :email, :string, unique: true, null: false
      t.column :password_digest, null: false
      t.column :preferred_name
      t.column :phone

      t.timestamps
    end
  end
end
