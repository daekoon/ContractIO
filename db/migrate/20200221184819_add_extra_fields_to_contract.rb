class AddExtraFieldsToContract < ActiveRecord::Migration[5.2]
  def change
    add_column :contracts, :loan_duration, :integer
    add_column :contracts, :interest_rate, :float

  end
end
