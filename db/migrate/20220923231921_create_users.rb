class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :credit_card
      t.string :address
      t.string :mobile
      t.string :email
      t.string :password
      t.boolean :is_admin

      t.timestamps
    end
  end
end
