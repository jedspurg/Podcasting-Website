class AddUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :first_name
      t.string  :last_name
      t.string  :username
      t.string  :password
      t.string  :email
      t.string  :role

      t.timestamps
    end
  end
end