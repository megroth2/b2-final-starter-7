require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "validations" do
    it { should validate_presence_of :status }
    it { should validate_presence_of :customer_id }
  end

  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many :transactions}
  end

  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Hair Care')
    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant_1.id, status: 1)
    @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant_1.id)
    @coupon_1 = create(:coupon, active: true, amount_off: 60, category: "percent-off", merchant_id: @merchant_1.id)
    
    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09", coupon_id: @coupon_1)
    
    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 1000, status: 2) # 10.00 x 9 = 90.00
    @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 1, unit_price: 1000, status: 1) # 10.00 x 1 = 10.00
  end

  it "calculates subtotal" do
    expect(@invoice_1.subtotal).to eq(10000)
  end

  it "calculates subtotal_in_dollars" do
    expect(@invoice_1.subtotal_in_dollars).to eq(100)
  end

  it "calculates grand_total_revenue_in_dollars for a percent-off coupon" do
    expect(@invoice_1.grand_total_revenue_in_dollars(@coupon_1)).to eq(40) # (90.00 + 10.00) - 60%(100.00)
  end

  it "calculates grand_total_revenue_in_dollars for a dollar-off coupon" do
    @coupon_1 = create(:coupon, active: true, amount_off: 1000, category: "dollar-off", merchant_id: @merchant_1.id)

    expect(@invoice_1.grand_total_revenue_in_dollars(@coupon_1)).to eq(90) # (90.00 + 10.00) - $10.00
  end
end
