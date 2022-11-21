# == Schema Information
#
# Table name: admins
#
#  id              :integer          not null, primary key
#  password_digest :string
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Admin < ApplicationRecord
  has_secure_password
end
