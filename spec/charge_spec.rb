require "spec_helper"

RSpec.describe Recharge::Charge do
  subject { described_class }

  it { is_expected.to be_a(Recharge::HTTPRequest::Get) }
  it { is_expected.to be_a(Recharge::HTTPRequest::Count) }

  it { is_expected.to define_const("PATH").set_to("/charges") }
  it { is_expected.to define_const("SINGLE").set_to("charge") }
  it { is_expected.to define_const("COLLECTION").set_to("charges") }
end
