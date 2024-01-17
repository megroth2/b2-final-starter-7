class Coupon < ApplicationRecord
  validates_uniqueness_of :code
  
  belongs_to :merchant
  has_many :invoices

  def use_count
    invoices.joins(:transactions).where(transactions: { result: 1 }).distinct.count
  end

  def status
    status = "active" if active == true
    status = "inactive" if active == false
    status
  end
end