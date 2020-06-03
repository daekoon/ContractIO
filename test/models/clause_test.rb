# == Schema Information
#
# Table name: clauses
#
#  id               :bigint           not null, primary key
#  custom           :boolean
#  explanation_text :string
#  name             :string
#  tags             :string           is an Array
#  template_name    :string
#  text             :string
#
require 'test_helper'

class ClauseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
