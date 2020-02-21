class CreateClauseTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :clause_templates do |t|
      t.string :name
      t.string :text
      t.timestamps
    end
  end
end
