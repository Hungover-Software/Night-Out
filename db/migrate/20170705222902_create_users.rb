class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :preferred_name
      t.string :phone_number
      t.string :salt
      
      t.timestamps
    end
  end
end
