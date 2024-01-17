class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :coupon, optional: true
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  # enum status: [:cancelled, :in_progress, :completed]
  enum :status, {cancelled: 0, "in progress": 1, completed: 2 }

  def subtotal
    invoice_items.sum("unit_price * quantity")
  end

  def subtotal_in_dollars
    invoice_items.sum("unit_price / 100 * quantity")
  end

  def grand_total_revenue_in_dollars(coupon) # includes coupon discounts
    if coupon.category == "percent-off"
      # divide amount_off by 100, subtract from 1, multiply by subtotal
      grand_total = subtotal_in_dollars * (1 - (coupon.amount_off / 100.0))
    elsif coupon.category == "dollar-off"
      # subtract amount_off from subtotal
      grand_total = subtotal_in_dollars - coupon.amount_off / 100.0
    else 
      grand_total = subtotal_in_dollars
    end
    grand_total
  end
end
