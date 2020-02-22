class CreateTerms < ActiveRecord::Migration[5.2]
  def change
    create_table :terms do |t|
      t.string :text
      t.string :explanation

      t.timestamps
    end
  end
end
