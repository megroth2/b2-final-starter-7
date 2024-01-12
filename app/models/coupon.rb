class Coupon < ApplicationRecord
  validates_uniqueness_of :code
  
  belongs_to :merchant
  has_many :invoices

end