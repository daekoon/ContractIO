class CreateClauses < ActiveRecord::Migration[5.2]
  def change
    create_table :clauses do |t|
        
      t.string :name
      t.string :tags, array: true
      t.string :text
    end
  end
end
