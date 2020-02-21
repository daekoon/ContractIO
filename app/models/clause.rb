# == Schema Information
#
# Table name: clauses
#
#  id   :bigint           not null, primary key
#  name :string
#  tags :string           is an Array
#  text :string
#
class Clause < ApplicationRecord
end
