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
require "test_helper"

class AttemptTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
