$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "recharge"
require "json"

require "rspec"
require "time"
require "webmock/rspec"
require "erb_test_fixture"

RSpec.configure { |c| c.include ERBTestFixture }
Recharge.api_key = "XXX"

RSpec.shared_examples_for "a method that requires an id" do
  it "requires an id argument" do
    [nil, ""].each do |arg|
      expect { described_class.get(arg) }.to raise_error(ArgumentError, "id required")
    end
  end
end

RSpec::Matchers.define :define_const do |name|
  match do |klass|
    begin
      const = klass.const_get(name)
      value ? const == value : true
    rescue NameError
      false
    end
  end

  chain :set_to, :value

  failure_message do |actual|
    msg = "expected class #{actual} to define const #{expected}"
    msg << " with value '#{value}'" if value
    msg
  end
end
