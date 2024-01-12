require 'rails_helper'

describe Coupon do
  before(:each) do
    # @merchant = create(:merchant)
    @merchant_1 = Merchant.create!(name: "merchant 1")
    @coupon_1 = create(:coupon, merchant: @merchant_1)
  end

  describe "validations" do
    it { should validate_uniqueness_of :code }
  end
  
  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :invoices }
  end
end