# == Schema Information
#
# Table name: attempts
#
#  id                               :integer          not null, primary key
#  asked_questions_count            :integer
#  diagnosis_accompanying_illnesses :string
#  diagnosis_complications          :string
#  email                            :string
#  main_diagnosis                   :string
#  name                             :string
#  opened_ekg                       :boolean
#  opened_glukometr                 :boolean
#  opened_pulseoximetr              :boolean
#  opened_trop_test                 :boolean
#  phone                            :string
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

  def score
    score = 0
    score += main_diagnosis_correct? ? 50 : 0
    score -= JSON.parse(diagnosis_complications).count
    JSON.parse(diagnosis_accompanying_illnesses).each do |ill|
      correct_illnesses.include?(ill) ? score += 2 : score -= 0
    end
    correct_illnesses.each { |ill| score -= 0 unless diagnosis_accompanying_illnesses.include?(ill) }
    score += asked_questions_count
    score += 3 * instrumental_researches_opened.values.count(true)
    treatment_medicate_beautiful.values.flatten.each { |m| score += correct_drugs.include?(m) ? 5 : 0 }
    correct_drugs.each { |d| score -= 0 unless treatment_medicate_beautiful.values.flatten.include?(d) }
    JSON.parse(treatment_non_medicate).each { |t| correct_treatment_non_medicate.include?(t) ? score += 5 : score -= 0 }
    correct_treatment_non_medicate.each { |t| score -= 0 unless treatment_non_medicate.include?(t) }
    [score, 0].max
  end

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

  def treatment_medicate_beautiful
    treatment_medicate&.each_with_object({}) do |e, h|
      h[e['name']] = e['drugs']
    end
  end

  def instrumental_researches_opened
    {
     ekg: opened_ekg,
     glucometr: opened_glukometr,
     puseoximetr: opened_pulseoximetr,
     trop_test: opened_trop_test
    }
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

  def correct_drugs
    correct_treatment_medicate.each_with_object([]) do |h, arr|
      arr.append(*h[:drugs])
    end
  end

  def correct_treatment_non_medicate
    ['Внутривенный доступ',
     'Оксигенотерапия']
  end

  private

  def content_equal?(a, b)
    a.to_set == b.to_set
  end


end
