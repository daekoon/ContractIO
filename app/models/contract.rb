# == Schema Information
#
# Table name: contracts
#
#  id         :bigint           not null, primary key
#  name       :string
#  user_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Contract < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
end
