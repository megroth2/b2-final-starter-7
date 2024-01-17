require "rails_helper"

RSpec.describe "new coupon page" do 

  before(:each) do
    @merchant_1 = Merchant.create!(name: "Hair Care")

    visit new_merchant_coupon_path(@merchant_1)
  end

  describe "User Story 2. Merchant Coupon Create" do
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
      expect(page).to have_content("Name")
      expect(page).to have_content("Code")
      expect(page).to have_content("Amount Off")
      expect(page).to have_content("Category")

      fill_in("name", with: "20OFF_coupon")
      fill_in("code", with: "20OFF")
      fill_in("amount_off", with: "2000")
      fill_in("category", with: "dollar-off")
      click_button("Submit")

      expect(current_path).to eq(merchant_coupons_path(@merchant_1)) # "/merchants/#{@merchant_1.id}/coupons"
      expect(page).to have_link("20OFF_coupon")
      expect(page).to have_content("Amount Off: 2000")
    end
  end
end