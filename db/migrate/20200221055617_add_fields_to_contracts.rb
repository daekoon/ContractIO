class AddFieldsToContracts < ActiveRecord::Migration[5.2]
  def change
    add_column :contracts, :lender_address, :string
    add_column :contracts, :borrower_name, :string
    add_column :contracts, :lender_name, :string
    add_column :contracts, :loan_amount, :bigint
  end
end
