require 'rails_helper'

describe Coupon do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "merchant 1")

    @customer_1 = Customer.create!(first_name: "Joey", last_name: "Smith")

    @coupon_1 = create(:coupon, merchant: @merchant_1, active: true)
    @coupon_2 = create(:coupon, merchant: @merchant_1, active: false)

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, coupon_id: @coupon_1.id)
    @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2, coupon_id: @coupon_1.id)

    @transaction_1 = Transaction.create!(credit_card_number: 203942, result: 0, invoice_id: @invoice_1.id)
    @transaction_2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice_1.id)
    @transaction_3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice_2.id)
    @transaction_4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice_2.id)
  end

  describe "validations" do
    it { should validate_uniqueness_of :code }
  end
  
  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :invoices }
  end

  it "counts total uses based on successful transactions" do
    expect(@coupon_1.use_count).to eq(2) # if time, could beef up this testing with various scenarios
  end

  it "returns status based on active flag" do
    expect(@coupon_1.status).to eq("active")
    expect(@coupon_2.status).to eq("inactive")
  end

  it "returns true if any invoices are pending" do
    @invoice_3 = Invoice.create!(customer_id: @customer_1.id, status: 1, coupon_id: @coupon_1.id)

    expect(@coupon_1.invoices_pending?).to eq(true)
  end

  it "returns false if no invoices are pending" do
    expect(@coupon_1.invoices_pending?).to eq(false)
  end
end