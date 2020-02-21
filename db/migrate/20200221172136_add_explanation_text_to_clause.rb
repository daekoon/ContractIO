class AddExplanationTextToClause < ActiveRecord::Migration[5.2]
  def change
    add_column :clauses, :explanation_text, :string
  end
end
