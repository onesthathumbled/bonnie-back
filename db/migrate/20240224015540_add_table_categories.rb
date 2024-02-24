class AddTableCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.references :user, foreign_key: true
      t.string :category_name
      t.text :category_details
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
