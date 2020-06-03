class AddTemplateNameToClause < ActiveRecord::Migration[5.2]
  def change
    add_column :clauses, :template_name, :string
  end
end
