class AddTableTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.references :category, foreign_key: true
      t.string :task_name
      t.text :task_details
      t.boolean :completion_status, default: false
      t.integer :priority
      t.date :due_date
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
