class RenamePulkoksimert < ActiveRecord::Migration[6.1]
  def change
    rename_column :attempts, :opened_pulkoksimetr, :opened_pulseoximetr
  end
end
