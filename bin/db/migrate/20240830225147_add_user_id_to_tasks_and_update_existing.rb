# frozen_string_literal: true

class AddUserIdToTasksAndUpdateExisting < ActiveRecord::Migration[7.1]
  def up
    add_reference :tasks, :user, null: true, foreign_key: true

    # Assuming you have a default user or want to assign all tasks to the first user
    # Modify this part according to your needs
    default_user_id = User.first&.id

    # Update existing records
    Task.update_all(user_id: default_user_id) if default_user_id

    # Make user_id non-nullable after updating existing records
    change_column_null :tasks, :user_id, false
  end

  def down
    remove_reference :tasks, :user
  end
end
