class AddDataToContract < ActiveRecord::Migration[5.2]
  def change
    add_column :contracts, :data, :json, default: {}
  end
end
