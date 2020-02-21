# == Schema Information
#
# Table name: contracts
#
#  id               :bigint           not null, primary key
#  borrower_address :string
#  borrower_name    :string
#  clauses          :integer          default("{}"), is an Array
#  interest_rate    :float
#  lender_address   :string
#  lender_name      :string
#  loan_amount      :bigint
#  loan_duration    :integer
#  name             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :bigint
#
# Indexes
#
#  index_contracts_on_user_id                 (user_id)
#  index_contracts_on_user_id_and_created_at  (user_id,created_at)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Contract < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
end
