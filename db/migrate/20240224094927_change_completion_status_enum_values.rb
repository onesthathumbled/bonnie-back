class ChangeCompletionStatusEnumValues < ActiveRecord::Migration[7.0]
  def change
    # Remove the old boolean column
    remove_column :tasks, :completion_status

    # Add a new integer column with a default value of 0
    add_column :tasks, :completion_status, :integer, default: 0
  end
end
