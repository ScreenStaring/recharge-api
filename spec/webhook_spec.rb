require "spec_helper"

RSpec.describe Recharge::Webhook do
  subject { described_class }

  it { is_expected.to be_a(Recharge::HTTPRequest::Create) }
  it { is_expected.to be_a(Recharge::HTTPRequest::Delete) }
  it { is_expected.to be_a(Recharge::HTTPRequest::Get) }
  it { is_expected.to be_a(Recharge::HTTPRequest::List) }
  it { is_expected.to be_a(Recharge::HTTPRequest::Update) }
  it { is_expected.to define_const("PATH").set_to("/webhooks") }

  describe ".new" do
    it "instantiates a webhook object with the given attributes" do
      data = {
        "id" => 1,
        "addresses" => "https://example.com",
        "topic" => "order/create"
      }
    end
  end

  context "an instance" do
    subject { described_class.new }
    it { is_expected.to be_a(Recharge::Persistable) }
  end
end
