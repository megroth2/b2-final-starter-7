class AddCouponToInvoices < ActiveRecord::Migration[7.0]
  def change
    add_reference :invoices, :coupon, null: false, foreign_key: true, optional: true
  end
end
