require "spec_helper"

describe Recharge::Persistable do
  # Can't use Struct since we need to_h to return String keys
  class2 :foo => %w[id bar] do
    include Recharge::Persistable
  end

  describe "#save" do
    context "given an instance without an id" do
      it "creates the record" do
        foo = Foo.new(:bar => "blah")

        expect(Foo).to receive(:create).with("bar" => "blah").and_return(instance_double("Foo", :id => 1))
        foo.save

        expect(foo.id).to eq 1
      end
    end

    context "given an instance with an id" do
      it "updates the record" do
        foo = Foo.new(:id => 2, :bar => "blah")

        expect(Foo).to receive(:update).with(2, "bar" => "blah")
        foo.save

        expect(foo.id).to eq 2
      end
    end
  end
end
