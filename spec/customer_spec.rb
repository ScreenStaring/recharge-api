require "spec_helper"

RSpec.describe Recharge::Customer do
  subject { described_class }

  it { is_expected.to be_a(Recharge::HTTPRequest::Create) }
  it { is_expected.to be_a(Recharge::HTTPRequest::Get) }
  it { is_expected.to be_a(Recharge::HTTPRequest::Update) }
  it { is_expected.to be_a(Recharge::HTTPRequest::List) }
  it { is_expected.to be_a(Recharge::HTTPRequest::Count) }

  it { is_expected.to define_const("PATH").set_to("/customers") }
  it { is_expected.to define_const("SINGLE").set_to("customer") }
  it { is_expected.to define_const("COLLECTION").set_to("customers") }

  describe ".new" do
    it "instantiates a customer object with the given attributes" do
      data = {
        "id" => 1,
        "hash" => "X123",
        "shopify_customer_id" => "Y999",
        "email" => "sshaw@screenstaring.com",
        "created_at" => "2018-01-10T11:00:00",
        "updated_at" => "2017-01-11T13:16:19",
        "first_name" => "Mike",
        "last_name" => "Flynn",
        "billing_first_name" => "S",
        "billing_last_name" => "SS",
        "billing_company" => "Company",
        "billing_address1" => "Address",
        "billing_address2" => "Address2",
        "billing_zip" => "90210",
        "billing_city" => "LA",
        "billing_province" => "CA",
        "billing_country" => "USA",
        "billing_phone" => "5555551213",
        "processor_type" => "stripe",
        "status" => "X",
        "stripe_customer_token" => "stripetok",
        "paypal_customer_token" => "pptok",
        "braintree_customer_token" => "bttok",
        "external_customer_id" => { "ecommerce" => "FooFoo" }
      }

      sub = described_class.new(data)
      expect(sub.to_h).to eq data
    end
  end

  describe ".create_address" do
    it_behaves_like "a method that requires an id"

    it "makes a POST request to the customer's address end endpoint with the given data" do
      id = 1
      address = Recharge::Address.new("customer_id" => id)
      expect(described_class).to receive(:POST)
      	                           .with("/customers/#{id}/addresses", address.to_h)
                                   .and_return("address" => { "customer_id" => id })

      expect(described_class.create_address(id, address.to_h)).to eq address
    end
  end

  describe ".addresses" do
    it_behaves_like "a method that requires an id"

    it "makes a GET request to the customer's address endpoint for the given id" do
      id = 1
      address = Recharge::Address.new("id" => id)
      expect(described_class).to receive(:GET)
      	                           .with("/customers/#{id}/addresses")
                                   .and_return("addresses" => [address.to_h])

      expect(described_class.addresses(id)).to eq [address]
    end
  end

  context "an instance" do
    subject { described_class.new }
    it { is_expected.to be_a(Recharge::Persistable) }
  end
end
