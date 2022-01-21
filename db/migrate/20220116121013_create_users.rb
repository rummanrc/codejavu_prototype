class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.email :email
      t.string :password_digest

      t.timestamps
    end
  end
end
