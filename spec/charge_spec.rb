require "spec_helper"

RSpec.describe Recharge::Charge do
  subject { described_class }

  it { is_expected.to be_a(Recharge::HTTPRequest::Get) }
  it { is_expected.to be_a(Recharge::HTTPRequest::Count) }
  it { is_expected.to be_a(Recharge::HTTPRequest::List) }

  it { is_expected.to define_const("PATH").set_to("/charges") }
  it { is_expected.to define_const("SINGLE").set_to("charge") }
  it { is_expected.to define_const("COLLECTION").set_to("charges") }

  describe ".skip" do
    it "makes a POST request to the skip endpoint with the given id and subscription id" do
      sub_id = 999
      charge = described_class.new(:id => 123)

      expect(described_class).to receive(:POST)
      	                           .with("/charges/#{charge.id}/skip", :subscription_id => sub_id)
                                   .and_return("charge" => { "id" => charge.id })

      expect(described_class.skip(charge.id, sub_id)).to eq charge
    end
  end

  describe ".change_next_charge_date" do
    it "makes a POST request to the change_next_charge_date endpoint with the given id and date" do
      date = "2017-01-01"
      charge = described_class.new(:id => 123)

      expect(described_class).to receive(:POST)
      	                           .with("/charges/#{charge.id}/change_next_charge_date", :next_charge_date => date)
                                   .and_return("charge" => { "id" => charge.id })

      expect(described_class.change_next_charge_date(charge.id, date)).to eq charge
    end

    it "converts date/time instances" do
      TIME_INSTANCES.each do |time|
        expect(described_class).to receive(:POST)
      	                             .with("/charges/1/change_next_charge_date", :next_charge_date => format_time(time))
                                     .and_return("charge" => { "id" => 1 })

        described_class.change_next_charge_date(1, time)
      end
    end
  end

  describe ".list" do
    %i[date_min date_max].each do |param|
      it "filters on #{param}" do
        # set has_uncommited_changes as charge.to_h => { "has_uncommited_changes" => nil }
        # and Charge.new("has_uncommited_changes" => nil).has_uncommited_changes == false
        charge = described_class.new(:id => 1, :has_uncommited_changes => false)

        TIME_INSTANCES.each do |time|
          expect(described_class).to receive(:GET)
                                       .with("/charges", param => format_time(time))
                                       .and_return("charges" => [charge.to_h])

          expect(described_class.list(param => time)).to eq [charge]

          expect(described_class).to receive(:GET)
                                       .with("/charges", param => format_time(time))
                                       .and_return("charges" => [charge.to_h])

          expect(described_class.list(param => format_time(time))).to eq [charge]

        end
      end
    end
  end

  describe ".new" do
    it "instantiates a charge object with the given attributes" do
      data = {
        "id" => 1,
        "address_id" => 2,
        "analytics_data" => { "foo" => 999 },
        "billing_address" => {
          "city" => "NYC",
          "address1" => "555 5th ave",
          "address2" => "10th floor",
          "company"  => "foo",
          "country"  => "USA",
          "first_name" => "s",
          "last_name" => "shaw",
          "phone" => "555-555-1212",
          "province" => "BC",
          "zip" => "10000"
        },
        "shipping_address" => {
          "city" => "LA",
          "address1" => "123 Sepulveda Blvd.",
          "address2" => "10th floor",
          "company"  => "bar",
          "country"  => "USA",
          "first_name" => "s",
          "last_name" => "shaw",
          "phone" => "555-555-9999",
          "province" => "BC",
          "zip" => "90210"
        },
        "client_details" => {
          "browser_ip" => "127.0.0.1",
          "user_agent" => "Konquer"
        },
        "created_at" => "2017-01-01T00:00:00",
        "customer_hash" => "X123",
        "customer_id" => 3,
        "first_name" => "sshaw",
        "last_name" => "xxx",
        "has_uncommited_changes" => false,
        "line_items" => [
          "images" => { "small" => "http://example.com/foo.webp" },
          "subscription_id" => 9999,
          "quantity" => 10,
          "shopify_product_id" => "90",
          "shopify_variant_id" => "91",
          "sku" => "SKU111",
          "title" => "Foo Product",
          "variant_title" => "Foo Variant",
          "vendor" => "Plug Depot",
          "grams" => 453,
          "price" => 100.0,
          "properties" => [
             {
               "name" => "x",
               "value" => "y"
             }
           ]
        ],
        "note" => "noted",
        "note_attributes" => [:a => 123],
        "processed_at" => "2017-01-01T00:00:00",
        "processor_name" => "sshaw",
        "scheduled_at" => "2014-01-05T00:00:00",
        "shipments_count" => 4,
        "shopify_order_id" => "5",
        "shipping_lines" => [
          "price" => "0.00",
          "code" => "Standard Shipping",
          "title" => "Standard Shipping"
        ],
        "status" => "SUCCESS",
        "total_price" => 1.0,
        "tax_lines" => 0,
        "total_discounts" => "0.0",
        "total_line_items_price" => "12.00",
        "total_price" => "12.00",
        "total_refunds" => nil,
        "total_tax" => 0,
        "total_weight" => 4536,
        "transaction_id" => "XX_XX",
        "type" => "RECURRING",
        "updated_at" => "2017-01-03T00:00:00"
      }

      charge = described_class.new(data)
      expect(charge.to_h).to eq data
    end
  end
end
