class Group < ApplicationRecord
  has_many :attempts

  def link
    "#{base_url}/quiz/#{self.id}/quiz"
  end

end
