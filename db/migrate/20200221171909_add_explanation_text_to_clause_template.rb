class AddExplanationTextToClauseTemplate < ActiveRecord::Migration[5.2]
  def change
    add_column :clause_templates, :explanation_text, :string
  end
end
