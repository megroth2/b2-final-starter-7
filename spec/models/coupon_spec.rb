require 'rails_helper'

describe Coupon do
  # before(:each) do
  #   @merchant = create(:merchant)
  #   @coupon = create(:coupon, merchant: @merchant)
  # end

  xdescribe "validations" do
    it { should validate_uniqueness_of :code }
  end
  
  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :invoices }
  end
end