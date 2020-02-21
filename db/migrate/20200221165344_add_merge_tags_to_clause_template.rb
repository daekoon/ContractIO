class AddMergeTagsToClauseTemplate < ActiveRecord::Migration[5.2]
  def change
    add_column :clause_templates, :merge_tags, :string, array: true, default: []
  end
end
