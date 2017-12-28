class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :chefs, :name, :chefName
  end
end
