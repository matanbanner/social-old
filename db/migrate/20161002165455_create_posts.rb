class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.references :publisher, foreign_key: true
      t.references :shared, foreign_key: true

      t.timestamps
    end
  end
end
