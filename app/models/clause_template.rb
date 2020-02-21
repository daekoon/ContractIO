# == Schema Information
#
# Table name: clause_templates
#
#  id               :bigint           not null, primary key
#  explanation_text :string
#  merge_tags       :string           default("{}"), is an Array
#  name             :string
#  tag              :string
#  text             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class ClauseTemplate < ApplicationRecord

  def replace_merge_tags(parameters)
    replaced_text = text

    if parameters.count < merge_tags.count
      puts 'Insufficient parameter, %d parameters received, %d merge tags' % [parameters.count, merge_tags.count]
      return text
    end

    counter = 0
    merge_tags.each do |tag|
      regex = Regexp.new(tag.to_s)
      replaced_text = replaced_text.gsub(regex, parameters[counter])
      counter += 1
    end

    replaced_text
  end

end
