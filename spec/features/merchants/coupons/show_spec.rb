require "rails_helper"

RSpec.describe "merchant coupon show page" do 
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Hair Care")
    
    @customer_1 = Customer.create!(first_name: "Joey", last_name: "Smith")

    @coupon_1 = create(:coupon, active: true, merchant: @merchant_1)
    @coupon_2 = create(:coupon, active: false, merchant: @merchant_1)

    visit merchant_coupon_path(@merchant_1, @coupon_1)
  end

  describe "User Story 3. Merchant Coupon Show Page" do
    # As a merchant 
    # When I visit a merchant's coupon show page 
    # I see that coupon's name and code 
    # And I see the percent/dollar off value
    # As well as its status (active or inactive)
    # And I see a count of how many times that coupon has been used.
    # (Note: "use" of a coupon should be limited to successful transactions.)
    
    it "shows coupon name, code, amount_off, status, and count of times used" do
      expect(page).to have_content(@coupon_1.name)
      expect(page).to have_content("Code: #{@coupon_1.code}")
      expect(page).to have_content("Amount Off: #{@coupon_1.amount_off}")
      expect(page).to have_content("Category: #{@coupon_1.category}")
      expect(page).to have_content("Status: active")
      expect(page).to have_content("Use Count: #{@coupon_1.use_count}")
    end
  end

  describe "User Story 4. Merchant Coupon Deactivate" do
    # As a merchant 
    # When I visit one of my active coupon's show pages
    # I see a button to deactivate that coupon
    # When I click that button
    # I'm taken back to the coupon show page 
    # And I can see that its status is now listed as 'inactive'.

    # * Sad Paths to consider: 
    # 1. A coupon cannot be deactivated if there are any pending invoices with that coupon.
 
    it "has a deactivate button to update coupon status" do
      expect(page).to have_button("Deactivate")

      click_button("Deactivate")

      expect(current_path).to eq(merchant_coupon_path(@merchant_1, @coupon_1))

      expect(page).to have_content("Status: inactive")
    end
 
    it "prevents deactivation if pending invoices belong to the coupon" do 
      @invoice_3 = Invoice.create!(customer_id: @customer_1.id, status: 1, coupon_id: @coupon_1.id)

      expect(page).to have_button("Deactivate")

      click_button("Deactivate")

      expect(current_path).to eq(merchant_coupon_path(@merchant_1, @coupon_1))
      expect(page).to have_content("Error: This coupon cannot be deactivated because it has pending invoices") 
      expect(page).to have_content("Status: active")
    end
  end

  describe "User Story 5. Merchant Coupon Activate" do
    # As a merchant 
    # When I visit one of my inactive coupon show pages
    # I see a button to activate that coupon
    # When I click that button
    # I'm taken back to the coupon show page 
    # And I can see that its status is now listed as 'active'.
 
    it "has an activate button to update coupon status" do
      visit merchant_coupon_path(@merchant_1, @coupon_2)

      expect(page).to have_button("Activate")

      click_button("Activate")

      expect(current_path).to eq(merchant_coupon_path(@merchant_1, @coupon_2))

      expect(page).to have_content("Status: active")
    end
  end

end