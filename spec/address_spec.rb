require "spec_helper"

RSpec.describe Recharge::Address do
  subject { described_class }

  it { is_expected.to be_a(Recharge::HTTPRequest::Get) }
  it { is_expected.to be_a(Recharge::HTTPRequest::Update) }
  it { is_expected.to define_const("PATH").set_to("/addresses") }
  it { is_expected.to define_const("SINGLE").set_to("address") }
  it { is_expected.to define_const("COLLECTION").set_to("addresses") }

  describe ".new" do
    it "instantiates an address object with the given attributes" do
      data = {
        "id" => 1,
        "customer_id" => 2,
        "address_id" => 3,
        "charge_id" => 4,
      }
    end
  end
end
