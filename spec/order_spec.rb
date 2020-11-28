require "spec_helper"

RSpec.describe Recharge::Order do
  subject { described_class }

  it { is_expected.to be_a(Recharge::HTTPRequest::Get) }
  it { is_expected.to be_a(Recharge::HTTPRequest::Count) }
  it { is_expected.to be_a(Recharge::HTTPRequest::List) }
  it { is_expected.to define_const("COLLECTION").set_to("orders") }
  it { is_expected.to define_const("SINGLE").set_to("order") }
  it { is_expected.to define_const("PATH").set_to("/orders") }

  describe ".new" do
    it "instantiates an order object with the given attributes" do
      data = {
        "id" => 1,
        "customer_id" => 2,
        "address_id" => 3,
        "charge_id" => 4,
        "transaction_id" => "TID",
        "shopify_order_id" => "5",
        "shopify_order_number" => 6,
        "created_at" => "2017-01-01",
        "updated_at" => "2017-01-02",
        "scheduled_at" => "2017-01-02",
        "processed_at" => "2017-01-03",
        "status" => "SUCCESS",
        "charge_status" => "SUCCESS",
        "type" => "CHECKOUT",
        "first_name" => "sshaw",
        "last_name" => "X",
        "email" => "s@example.com",
        "payment_processor" => "4 much",
        "address_is_active" => 1,
        "is_prepaid" => false,
        "line_items" => [],
        "total_price" => 100.0,
        "shipping_address" => [],
        "billing_address" => []
      }

      order = described_class.new(data)
      expect(order.to_h).to eq data
    end
  end

  describe ".get" do
    it_behaves_like "a method that requires an id"

    it "makes a GET request to the orders endpoint for the given id" do
      id = 123
      order = described_class.new(:id => id)
      expect(described_class).to receive(:GET)
      	                           .with("/orders/#{id}")
                                   .and_return("order" => { "id" => id })

      expect(described_class.get(id)).to eq order
    end
  end

  describe ".update_shopify_variant" do
    it "makes a POST request to update_shopify_variant" do
      old_variant_id = 999
      new_variant_id = 123
      order = described_class.new(:id => 123)

      expect(described_class).to receive(:POST)
      	                           .with("/orders/#{order.id}/update_shopify_variant/#{old_variant_id}", :new_shopify_variant_id => 123)
                                   .and_return("order" => { "id" => new_variant_id })


      expect(described_class.update_shopify_variant(order.id, old_variant_id, new_variant_id)).to eq described_class.new(:id => 123)
    end
  end

  describe ".change_date" do
    it "makes a POST request to change_date with the given order id" do
      order = described_class.new(:id => 1)
      time = Time.new

      expect(described_class).to receive(:POST)
      	                           .with("/orders/#{order.id}/change_date", :shipping_date => format_time(time))
                                   .and_return("order" => { "id" => 1 })


      expect(described_class.change_date(order.id, time)).to eq order
    end
  end

  describe ".count" do
    before do
      @path = "/orders/count"
      @retval = { "count" => 1 }
    end

    it "makes a GET request to count and returns the count" do
      expect(described_class).to receive(:GET)
      	                           .with(@path, nil)
                                   .and_return(@retval)

      expect(described_class.count).to eq 1
    end

    %i[created_at_max created_at_min date_min date_max].each do |param|
      it "filters the count on #{param}" do
        time = Time.now

        expect(described_class).to receive(:GET)
      	                             .with(@path, param => format_time(time))
                                     .and_return(@retval).twice

        expect(described_class.count(param => time)).to eq 1
        expect(described_class.count(param => format_time(time))).to eq 1
      end
    end
  end
end
