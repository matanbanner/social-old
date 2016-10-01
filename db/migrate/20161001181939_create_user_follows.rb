class CreateUserFollows < ActiveRecord::Migration[5.0]
  def change
    create_table :user_follows do |t|
      t.references :from_user
      t.references :to_user

      t.timestamps
    end
  end
end
