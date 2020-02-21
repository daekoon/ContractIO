# == Schema Information
#
# Table name: clauses
#
#  id               :bigint           not null, primary key
#  explanation_text :string
#  name             :string
#  tags             :string           is an Array
#  text             :string
#
class Clause < ApplicationRecord
end
