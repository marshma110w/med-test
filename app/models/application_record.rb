class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def base_url
    'localhost:3000'
  end
end
