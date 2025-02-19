class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      #internal fields
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.string :role

      t.timestamps
    end
  end
end
