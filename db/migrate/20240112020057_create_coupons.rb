class CreateCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :coupons do |t|
      t.string :name
      t.string :code
      t.string :category
      t.integer :amount_off
      t.boolean :active

      t.timestamps
    end
  end
end
