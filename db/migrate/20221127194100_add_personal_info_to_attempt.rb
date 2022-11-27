class AddPersonalInfoToAttempt < ActiveRecord::Migration[6.1]
  def change
    add_column :attempts, :name, :string
    add_column :attempts, :phone, :string
    add_column :attempts, :email, :string
  end
end
