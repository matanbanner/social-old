class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :country
      t.date :birthday
      t.string :profile_picture
      t.string :cover_photo
      t.string :status

      t.timestamps
    end
  end
end
