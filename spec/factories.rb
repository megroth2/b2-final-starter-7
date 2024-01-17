FactoryBot.define do
  factory :customer do
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
  end

  factory :invoice do
    status {[0,1,2].sample}
    merchant
    customer
  end

  factory :merchant do
    name {Faker::Space.galaxy}
    invoices
    items
  end

  factory :item do
    name {Faker::Commerce.product_name}
    description {Faker::Hipster.sentence}
    unit_price {Faker::Number.decimal(l_digits: 2)}
    merchant
  end

  factory :transaction do
    result {[0,1].sample}
    credit_card_number {Faker::Finance.credit_card}
    invoice
  end

  factory :invoice_item do
    status {[0,1,2].sample}
    merchant
    invoice
  end

  factory :coupon do
    name {"#{code}_coupon"}
    code {Faker::Commerce.promotion_code}
    category { ["percent-off", "dollar-off"].sample }
    amount_off { ["#{rand(100)}%", "$#{rand(1..100)}"].sample }
    active {false}
    merchant 
  end
end
