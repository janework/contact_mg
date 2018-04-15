class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :firstname
      t.string :lastname
      t.string :tel
      t.string :email
      t.string :address

      t.timestamps
    end
  end
end
