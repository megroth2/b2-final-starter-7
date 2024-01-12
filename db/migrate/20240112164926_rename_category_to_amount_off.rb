class RenameCategoryToAmountOff < ActiveRecord::Migration[7.0]
  def change
    rename_column(:coupons, :category, :amount_off)
  end
end
