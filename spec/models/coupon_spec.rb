require 'rails_helper'

describe Coupon do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "merchant 1")

    @customer_1 = Customer.create!(first_name: "Joey", last_name: "Smith")

    @coupon_1 = create(:coupon, merchant: @merchant_1)

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
end