# == Schema Information
#
# Table name: terms
#
#  id          :bigint           not null, primary key
#  explanation :string
#  text        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'test_helper'

class TermTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
