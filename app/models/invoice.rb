class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :coupon, optional: true
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum :status, {cancelled: 0, "in progress": 1, completed: 2 }

  def subtotal
    invoice_items.sum("unit_price * quantity")
  end

  def merchant_subtotal(merchant)
    invoice_items.where(item.merchant_id = merchant.id).sum("unit_price * quantity")
  end

  def grand_total_revenue(coupon = nil) # includes coupon discounts
    if coupon.present? && coupon.category == "percent-off"
      # subtract amount_off from 1, multiply by subtotal
      grand_total = (subtotal/100) * (1 - (coupon.amount_off / 100.0))
      # sad path: only apply the discount on items that belong to the coupon's merchant (use merchant_subtotal instead of subtotal)
    elsif coupon.present? && coupon.category == "dollar-off"
      # subtract amount_off from subtotal
      grand_total = subtotal/100 - coupon.amount_off/100
    else 
      # no coupon, so the grand total is the same
      grand_total = subtotal
    end
    # grand total cannot be less than 0
    grand_total = 0 if grand_total < 0
    grand_total
  end
end