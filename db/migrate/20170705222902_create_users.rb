class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.column :email, :string, unique: true, null: false
      t.column :password_digest, :string, :null => false
      t.column :preferred_name, :string
      t.column :phone, :string

      t.timestamps
    end
  end
end
