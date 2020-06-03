class AddCustomToClause < ActiveRecord::Migration[5.2]
  def change
    add_column :clauses, :custom, :boolean
  end
end
