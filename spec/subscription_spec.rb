require "spec_helper"

RSpec.describe Recharge::Subscription do
  subject { described_class }

  it { is_expected.to be_a(Recharge::HTTPRequest::Create) }
  it { is_expected.to be_a(Recharge::HTTPRequest::Get) }
  it { is_expected.to be_a(Recharge::HTTPRequest::Update) }
  it { is_expected.to be_a(Recharge::HTTPRequest::List) }

  it { is_expected.to define_const("PATH").set_to("/subscriptions") }
  it { is_expected.to define_const("SINGLE").set_to("subscription") }
  it { is_expected.to define_const("COLLECTION").set_to("subscriptions") }

  context "an instance" do
    subject { described_class.new }
    it { is_expected.to be_a(Recharge::Persistable) }
  end
end
