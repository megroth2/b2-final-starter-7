require "rails_helper"

RSpec.describe "coupon show page" do 
  xdescribe "User Story 3. Merchant Coupon Show Page" do
    # As a merchant 
    # When I visit a merchant's coupon show page 
    # I see that coupon's name and code 
    # And I see the percent/dollar off value
    # As well as its status (active or inactive)
    # And I see a count of how many times that coupon has been used.
    # (Note: "use" of a coupon should be limited to successful transactions.)
    
    it "shows coupon name, code, amount_off, status, and count of times used" do

    end
  end

  xdescribe "User Story 4. Merchant Coupon Deactivate" do
    # As a merchant 
    # When I visit one of my active coupon's show pages
    # I see a button to deactivate that coupon
    # When I click that button
    # I'm taken back to the coupon show page 
    # And I can see that its status is now listed as 'inactive'.
    # * Sad Paths to consider: 
    # 1. A coupon cannot be deactivated if there are any pending invoices with that coupon.
 
    it "has a deactivate button to update coupon status" do
 
    end
 
    it "prevents deactivation if pending invoices belong to the coupon" do 
 
    end
  end

  xdescribe "User Story 5. Merchant Coupon Activate" do
    # As a merchant 
    # When I visit one of my inactive coupon show pages
    # I see a button to activate that coupon
    # When I click that button
    # I'm taken back to the coupon show page 
    # And I can see that its status is now listed as 'active'.
 
    it "has an activate button to update coupon status" do
 
    end
  end

end