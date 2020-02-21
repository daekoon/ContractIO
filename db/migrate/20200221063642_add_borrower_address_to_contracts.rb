class AddBorrowerAddressToContracts < ActiveRecord::Migration[5.2]
  def change
    add_column :contracts, :borrower_address, :string
  end
end
