require "rails_helper"

RSpec.describe "merchant coupons index" do

  before(:each) do
    @merchant_1 = Merchant.create!(name: "Hair Care")

    @customer_1 = Customer.create!(first_name: "Joey", last_name: "Smith")
    @customer_2 = Customer.create!(first_name: "Cecilia", last_name: "Jones")
    @customer_3 = Customer.create!(first_name: "Mariah", last_name: "Carrey")
    @customer_4 = Customer.create!(first_name: "Leigh Ann", last_name: "Bron")
    @customer_5 = Customer.create!(first_name: "Sylvester", last_name: "Nader")
    @customer_6 = Customer.create!(first_name: "Herber", last_name: "Kuhn")

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2)
    @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2)
    @invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 2)
    @invoice_4 = Invoice.create!(customer_id: @customer_3.id, status: 2)
    @invoice_5 = Invoice.create!(customer_id: @customer_4.id, status: 2)
    @invoice_6 = Invoice.create!(customer_id: @customer_5.id, status: 2)
    @invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: 1)

    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant_1.id)
    @item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant_1.id)
    @item_4 = Item.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1, merchant_id: @merchant_1.id)

    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0)
    @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 1, unit_price: 8, status: 0)
    @ii_3 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 2)
    @ii_4 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_5 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_6 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_7 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)

    @transaction_1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
    @transaction_2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice_3.id)
    @transaction_3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice_4.id)
    @transaction_4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice_5.id)
    @transaction_5 = Transaction.create!(credit_card_number: 102938, result: 1, invoice_id: @invoice_6.id)
    @transaction_6 = Transaction.create!(credit_card_number: 879799, result: 1, invoice_id: @invoice_7.id)
    @transaction_7 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_2.id) # are these intentionally out of order?

    @coupon_1 = Coupon.create!(name: "1", code: "1", amount_off: "asdj", active: true, merchant: @merchant_1) # use factory bot
    @coupon_2 = Coupon.create!(name: "2", code: "2", amount_off: "asdj", active: true, merchant: @merchant_1) # use factory bot
    @coupon_3 = Coupon.create!(name: "3", code: "3", amount_off: "asdj", active: true, merchant: @merchant_1) # use factory bot
    @coupon_4 = Coupon.create!(name: "4", code: "4", amount_off: "asdj", active: true, merchant: @merchant_1) # use factory bot
    @coupon_5 = Coupon.create!(name: "5", code: "5", amount_off: "asdj", active: true, merchant: @merchant_1) # use factory bot

    visit merchant_coupons_path(@merchant_1)
  end

  describe "User Story 1" do
    # 1. Merchant Coupons Index 
    # As a merchant
    # When I visit my merchant dashboard page
    # I see a link to view all of my coupons
    # When I click this link
    # I'm taken to my coupons index page
    # Where I see all of my coupon names including their amount off 
    # And each coupon's name is also a link to its show page.

    it "displays all coupons" do
      # visit("/merchants/#{@merchant_1.id}/coupons")

      expect(page).to have_link("#{@coupon_1.name}")
      expect(page).to have_content("Amount off: #{@coupon_1.amount_off}")

      click_link("#{@coupon_1.name}")

      expect(current_path).to eq(merchant_coupon_path, @merchant_1, @coupon_1)
    end
  end
end