require "spec_helper"

RSpec.describe Recharge::Discount do
  subject { described_class }

  it { is_expected.to be_a(Recharge::HTTPRequest::Create) }
  it { is_expected.to define_const("PATH").set_to("/discounts") }
  it { is_expected.to define_const("SINGLE").set_to("discount") }

  describe ".new" do
    it "instantiates an discount object with the given attributes" do
      data = {
        "id" => 1,
        "code" => "X99",
        "created_at" => "2018-12-31",
        "value" => 99,
        "applies_to_id" => 6,
        "applies_to_product_type" => "foo",
        "discount_type" => "percentage",
        "applies_to" => 132,
        "applies_to_resource" => "Foo",
        "times_used" => 0,
        "duration" => "10 days",
        "once_per_customer" => false,
        "starts_at" => "2019-01-01",
        "ends_at" => "2019-01-11",
        "duration_usage_limit" => nil,
        "status" => nil,
        "updated_at" => nil,
        "usage_limit" => nil
      }

      discount = described_class.new(data)
      expect(discount.to_h).to eq data
    end
  end
end
