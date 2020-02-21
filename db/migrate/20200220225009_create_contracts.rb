class CreateContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :contracts do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.string :lender_address
      t.string :borrower_name
      t.string :lender_name
      t.string :borrower_address
      t.bigint :loan_amount
      t.integer :clauses, array: true, default: []

      t.timestamps
    end
    add_index :contracts, [:user_id, :created_at]
  end
end
