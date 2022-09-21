class QuizController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :attempt

  def welcome
  end

  def quiz
  end

  def final
  end

  def attempt

    attempt = Attempt.new

    #STUB
    attempt.group = Group.find(1)

    attempt.asked_questions_count = params[:askedQuestionsCount]

    attempt.opened_pulkoksimetr = params[:openedPulkoksimetr]
    attempt.opened_ekg = params[:openedEkg]
    attempt.opened_glukometr = params[:openedGlukometr]
    attempt.opened_trop_test = params[:openedTroponinovyjTest]

    attempt.main_diagnosis = params[:diagnosisMain]
    attempt.diagnosis_complications = params[:diagnosisComplications]
    attempt.diagnosis_accompanying_illnesses = params[:diagnosisAccompanyingIllnesses]

    attempt.treatment_medicate = params[:treatmentMedicate]
    attempt.treatment_non_medicate = params[:treatmentNonMedicate]

    if attempt.valid?
      attempt.save
      render plain: 'Результат сохранен', status: :ok
    else
      render plain: attempt.errors.to_a.join(', '), status: :unprocessable_entity
    end
  end
end
