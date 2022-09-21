class CreateAttempts < ActiveRecord::Migration[6.1]
  def change
    create_table :attempts do |t|
      t.belongs_to :group
      t.integer :asked_questions_count, :integer, null: false, default: 0
      t.boolean :opened_pulkoksimetr
      t.boolean :opened_ekg
      t.boolean :opened_glukometr
      t.boolean :opened_trop_test

      t.string :main_diagnosis, null: false, default: ''
      t.string :diagnosis_complications, array: true
      t.string :diagnosis_accompanying_illnesses, array: true

      t.json :treatment_medicate
      t.string :treatment_non_medicate, array: true

      t.timestamps
    end
  end
end
