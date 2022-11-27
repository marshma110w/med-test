class FixAttempts < ActiveRecord::Migration[6.1]
  def change
    remove_column :attempts, :integer, :integer
    change_column_default :attempts, :asked_questions_count, from: 0, to: nil
    change_column_default :attempts, :main_diagnosis, from: "", to: nil
    change_column_null :attempts, :asked_questions_count, true
    change_column_null :attempts, :main_diagnosis, true
  end
end
