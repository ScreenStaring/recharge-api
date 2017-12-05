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

  describe ".set_next_charge_date" do
    it "makes a POST request set_next_charge_date with the given subscription id and date" do
      sub = described_class.new(:id => 1)
      time = "2017-01-01T00:00"

      expect(described_class).to receive(:POST)
      	                           .with("/subscriptions/#{sub.id}/set_next_charge_date", :date => time)
                                   .and_return("subscription" => { "id" => sub.id })


      expect(described_class.set_next_charge_date(sub.id, time)).to eq sub
    end

    it "converts date/time instances" do
      id = 1
      TIME_INSTANCES.each do |time|
        expect(described_class).to receive(:POST)
      	                             .with("/subscriptions/#{id}/set_next_charge_date", :date => format_time(time))
                                     .and_return("subscription" => { "id" => id })

        described_class.set_next_charge_date(id, time)
      end
    end
  end

  describe ".list" do
    %i[created_at created_at_max updated_at updated_at_max].each do |param|
      it "filters on #{param}" do
        sub = described_class.new(:id => 1)

        TIME_INSTANCES.each do |time|
          expect(described_class).to receive(:GET)
      	                               .with("/subscriptions", param => format_time(time))
                                       .and_return("subscriptions" => ["id" => 1])

          expect(described_class.list(param => time)).to eq [ sub ]


          expect(described_class).to receive(:GET)
      	                               .with("/subscriptions", param => format_time(time))
                                       .and_return("subscriptions" => ["id" => 1])

          expect(described_class.list(param => format_time(time))).to eq [ sub ]
        end
      end
    end
  end

  context "an instance" do
    subject { described_class.new }
    it { is_expected.to be_a(Recharge::Persistable) }
  end
end
