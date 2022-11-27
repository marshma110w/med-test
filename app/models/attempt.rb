# == Schema Information
#
# Table name: attempts
#
#  id                               :integer          not null, primary key
#  asked_questions_count            :integer          default(0), not null
#  diagnosis_accompanying_illnesses :string
#  diagnosis_complications          :string
#  integer                          :integer          default(0), not null
#  main_diagnosis                   :string           default(""), not null
#  opened_ekg                       :boolean
#  opened_glukometr                 :boolean
#  opened_pulseoximetr              :boolean
#  opened_trop_test                 :boolean
#  treatment_medicate               :json
#  treatment_non_medicate           :string
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#  group_id                         :integer
#
# Indexes
#
#  index_attempts_on_group_id  (group_id)
#
class Attempt < ApplicationRecord
  belongs_to :group

  validates :asked_questions_count, :main_diagnosis, presence: true

  def main_diagnosis_correct?
    main_diagnosis == correct_main_diagnosis
  end

  def diagnosis_complications_correct?
    JSON.parse(diagnosis_complications).empty?
  end

  def diagnosis_accompanying_illnesses_correct?
    content_equal?(JSON.parse(diagnosis_accompanying_illnesses), correct_illnesses)
  end

  def treatment_medicate_correct?
    treatment = treatment_medicate.map(&:symbolize_keys).map do |h|
      h.merge(:drugs => h[:drugs].to_set )
    end
    content_equal?(treatment, correct_treatment_medicate)
  end

  def treatment_non_medicate_correct?
    content_equal?(JSON.parse(treatment_non_medicate), correct_treatment_non_medicate)
  end

  def instrumental_researches_opened
    {
     ekg: opened_ekg,
     glucometr: opened_glukometr,
     puseoximetr: opened_pulseoximetr,
     trop_test: opened_trop_test
    }
  end

  private

  def content_equal?(a, b)
    a.to_set == b.to_set
  end

  def correct_illnesses
    ['Сахарный диабет инсулиннезависимый',
     'Гипертоническая болезнь',
     'Остеохондроз позвоночника']
  end

  def correct_main_diagnosis
    'Острый коронарный синдром с подъёмом ST'
  end

  def correct_treatment_medicate
    [
      {
        name: 'Анальгетики',
        drugs: ['Морфин', 'Фентанил'].to_set,
      },
      {
        name: 'Нитраты',
        drugs: ['Нитроглицерин', 'Изосорбид динитрат'].to_set,
      },
      {
        name: 'Средства, влияющие на свертывание крови',
        drugs: ['Гепарин', 'Ацетилсалициловая кислота', 'Клопидогрел'].to_set,
      },
      {
        name: 'Тромболитики',
        drugs: ['Алтеплаза', 'Тенектеплаза', 'Фортелизин'].to_set,
      },
      {
        name: 'Антиаритмические средства',
        drugs: ['Метопролол'].to_set,
      }
    ]
  end

  def correct_treatment_non_medicate
    ['Внутривенный доступ',
     'Оксигенотерапия']
  end
end
