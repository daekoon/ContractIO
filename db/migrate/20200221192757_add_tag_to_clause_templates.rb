class AddTagToClauseTemplates < ActiveRecord::Migration[5.2]
  def change
    add_column :clause_templates, :tag, :string
  end
end
