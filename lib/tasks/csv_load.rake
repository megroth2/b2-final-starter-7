require 'csv'

namespace :csv_load do

  desc "Load Customers from customers.csv"
  task customers: :environment do
    CSV.foreach(Rails.root.join('db/data/customers.csv'), headers: true) do |row|
      Customer.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
    puts "Customers ✅"
  end

  desc "Load Merchants from merchants.csv"
  task merchants: :environment do
    CSV.foreach(Rails.root.join('db/data/merchants.csv'), headers: true) do |row|
      Merchant.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
    puts "Merchants ✅"
  end

  desc "Load Items from items.csv"
  task items: :environment do
    CSV.foreach(Rails.root.join('db/data/items.csv'), headers: true) do |row|
      Item.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
    puts "Items ✅"
  end
  
  desc "Load Invoices from invoices.csv"
  task invoices: :environment do
    CSV.foreach(Rails.root.join('db/data/invoices.csv'), headers: true) do |row|
      Invoice.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
    puts "Invoices ✅"
  end
  
  desc "Load Transactions from transactions.csv"
  task transactions: :environment do
    CSV.foreach(Rails.root.join('db/data/transactions.csv'), headers: true) do |row|
      Transaction.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
    puts "Transactions ✅"
  end
  
  desc "Load Invoice_items from invoice_items.csv"
  task invoice_items: :environment do
    CSV.foreach(Rails.root.join('db/data/invoice_items.csv'), headers: true) do |row|
      InvoiceItem.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
    puts "InvoiceItems ✅"
  end
  
  desc "Load all CSVs"
  task all: [:customers, :merchants, :items, :invoices, :transactions, :invoice_items] do
    puts "🏁🏁🏁🏁🏁🏁"
  end
  
end