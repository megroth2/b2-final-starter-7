require "rails_helper"

RSpec.describe "new coupon page" do 
  xdescribe "User Story 2. Merchant Coupon Create" do
    # As a merchant
    # When I visit my coupon index page 
    # I see a link to create a new coupon.
    # When I click that link 
    # I am taken to a new page where I see a form to add a new coupon.
    # When I fill in that form with a name, unique code, an amount, and whether that amount is a percent or a dollar amount
    # And click the Submit button
    # I'm taken back to the coupon index page 
    # And I can see my new coupon listed.

    # * Sad Paths to consider: 
    # 1. This Merchant already has 5 active coupons
    # 2. Coupon code entered is NOT unique

    it "has a form to create a new coupon with name, code, amount_off, category " do

    end
  end
end