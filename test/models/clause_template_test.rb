# == Schema Information
#
# Table name: clause_templates
#
#  id               :bigint           not null, primary key
#  explanation_text :string
#  merge_tags       :string           default("{}"), is an Array
#  name             :string
#  text             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require 'test_helper'

class ClauseTemplateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
