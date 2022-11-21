# == Schema Information
#
# Table name: groups
#
#  id          :integer          not null, primary key
#  custom_name :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Group < ApplicationRecord
  has_many :attempts

  def link
    "#{base_url}/quiz/#{self.id}/quiz"
  end

end
