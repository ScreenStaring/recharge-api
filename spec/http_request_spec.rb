require "spec_helper"

RSpec.describe Recharge::HTTPRequest do
  before do
    @meta     = { "id" => "X123000", "limit" => "1/50" }
    @response = { :a  => { :b => 1 } }
    @endpoint = "https://api.rechargeapps.com"
    @headers  = { "X-Recharge-Access-Token" => "XXX" }

    stub_request(:any, %r{#@endpoint/.*})
      .and_return(
        :headers => {
          "Content-Type"     => "application/json",
          "X-Request-Id"     => @meta["id"],
          "X-Recharge-Limit" => @meta["limit"]
        },
        :body   => @response.to_json
      )
  end

  describe ".GET" do
    before do
      @o = Object.new.extend described_class
      def @o.get(path, data = {})
        GET(path, data)
      end
    end

    after { ReCharge.api_version = nil }

    # FIXME: shared example
    it "uses the configured specified API version" do
      # Not a real version, FYI
      ReCharge.api_version = "2022-01-01"

      @o.get("/foo")
      expect(WebMock).to have_requested(:get, "#@endpoint/foo").with(:headers => @headers.merge("X-Recharge-Version" => "2022-01-01"))
    end

    it "generates a GET request to the given path" do
      @o.get("/foo")
      expect(WebMock).to have_requested(:get, "#@endpoint/foo").with(:headers => @headers)
    end

    it "generates a GET request to the given path with the given parameters" do
      @o.get("/bar", :a => 123, :b => 456)
      expect(WebMock).to have_requested(:get, "#@endpoint/bar")
                           .with(:query   => { :a => 123, :b => 456 },
                                 :headers => @headers)
    end

    context "given an application/json response" do
      it "parses the JSON and returns a Hash" do
        expect(@o.get("/")).to eq "a" => { "b" => 1 }, "meta" => @meta
      end
    end
  end

  describe ".POST" do
    before do
      @o = Object.new.extend described_class
      def @o.post(path, data = {})
        POST(path, data)
      end
    end

    it "generates a POST request to the given path" do
      @o.post("/foo")
      expect(WebMock).to have_requested(:post, "#@endpoint/foo").with(:headers => @headers)
    end

    it "generates a POST request to the given path with the given parameters" do
      @o.post("/bar", :a => 123, :b => 456)
      expect(WebMock).to have_requested(:post, "#@endpoint/bar")
                           .with(:body    => { :a => 123, :b => 456 },
                                 :headers => @headers)
    end

    context "given an application/json response" do
      it "parses the JSON and returns a Hash" do
        expect(@o.post("/")).to eq "a" => { "b" => 1 }, "meta" => @meta
      end
    end
  end

  describe ".PUT" do
    before do
      @o = Object.new.extend described_class
      def @o.put(path, data = {})
        PUT(path, data)
      end
    end

    it "generates a PUT request to the given path" do
      @o.put("/foo")
      expect(WebMock).to have_requested(:put, "#@endpoint/foo").with(:headers => @headers)
    end

    it "generates a PUT request to the given path with the given parameters" do
      @o.put("/bar", :a => 123, :b => 456)
      expect(WebMock).to have_requested(:put, "#@endpoint/bar")
                           .with(:body    => { :a => 123, :b => 456 },
                                 :headers => @headers)
    end
  end
end

RSpec.describe Recharge::HTTPRequest::Count do
  FooCount = Struct.new(:args) do
    extend Recharge::HTTPRequest::Count
  end

  FooCount::PATH = "/foo"

  describe ".count" do
    it "makes a GET request to PATH's count endpoint and returns the count" do
      expect(FooCount).to receive(:GET)
      	                    .with(FooCount::PATH + "/count", nil)
                            .and_return("count" => 1)

      expect(FooCount.count).to eq 1
    end

    it "makes a GET request to PATH's count endpoint with the given options" do
      args = { :foo => 1, :bar => 2 }
      expect(FooCount).to receive(:GET)
      	                    .with(FooCount::PATH + "/count", args)
                            .and_return("count" => 1)

      expect(FooCount.count(args)).to eq 1
    end
  end
end

RSpec.describe Recharge::HTTPRequest::Create do
  FooCreate = Struct.new(:args) do
    extend Recharge::HTTPRequest::Create
  end

  FooCreate::PATH = "/create"
  FooCreate::SINGLE = "create"

  describe ".create" do
    it "makes a POST request to PATH endpoint for the given data" do
      data = { :a => 1, :b => 2 }
      expect(FooCreate).to receive(:POST)
      	                     .with(FooCreate::PATH, data)
                             .and_return({})

      expect(FooCreate.create(data)).to eq FooCreate.new
    end

    it "returns an instance of the receiving class from the response" do
      data = { :a => 1, :b => 2 }
      expect(FooCreate).to receive(:POST)
      	                     .with(FooCreate::PATH, data)
                             .and_return(FooCreate::SINGLE => data)

      expect(FooCreate.create(data)).to eq FooCreate.new(data)
    end
  end
end

RSpec.describe Recharge::HTTPRequest::Delete do
  FooDelete = Struct.new(:args) do
    extend Recharge::HTTPRequest::Delete
  end

  FooDelete::PATH = "/delete"

  describe ".delete" do
    it "makes a DELETE request to PATH endpoint for the given id" do
      id = 123
      expect(FooDelete).to receive(:DELETE)
      	                     .with(FooDelete::PATH + "/#{id}")
                             .and_return({})

      expect(FooDelete.delete(id)).to eq({})
    end
  end
end


RSpec.describe Recharge::HTTPRequest::Get do
  FooGet = Struct.new(:args) do
    extend Recharge::HTTPRequest::Get
  end

  FooGet::PATH = "/get"
  FooGet::SINGLE = "get"

  describe ".get" do
    it "requires an id argument" do
      [nil, ""].each do |arg|
        expect { FooGet.get(arg) }.to raise_error(ArgumentError, "id required")
      end
    end

    it "makes a GET request to PATH endpoint for the given id" do
      id = 123
      expect(FooGet).to receive(:GET)
      	              .with(FooGet::PATH + "/#{id}")
                      .and_return({})

      expect(FooGet.get(id)).to eq FooGet.new
    end

    it "returns an instance of the receiving class from the response" do
      id = 123
      args = { "id" => id, "name" => "sshaw" }
      expect(FooGet).to receive(:GET)
      	              .with(FooGet::PATH + "/#{id}")
                      .and_return(FooGet::SINGLE => args)

      expect(FooGet.get(id)).to eq FooGet.new(args)
    end
  end
end

RSpec.describe Recharge::HTTPRequest::List do
  FooList = Struct.new(:args) do
    extend Recharge::HTTPRequest::List
  end

  FooList::PATH = "/list"
  FooList::COLLECTION = "foos"

  describe ".list" do
    it "makes a GET request to PATH endpoint with the given options" do
      args = { "page" => 1, "size" => 30 }
      expect(FooList).to receive(:GET)
      	                     .with(FooList::PATH, args)
                             .and_return({})

      expect(FooList.list(args)).to eq []
    end

    it "returns an array of instances of the receiving class" do
      meta = { "id" => "X123", "limit" => "0/40" }
      result = [
        FooList.new("name" => "sshaw", "meta" => meta),
        FooList.new("name" => "fofinha", "meta" => meta)
      ]

      expect(FooList).to receive(:GET)
      	                   .with(FooList::PATH, nil)
                           .and_return(
                             "meta" => meta,
                             FooList::COLLECTION => [
                               result[0].args,
                               result[1].args
                             ])

      expect(FooList.list).to eq result
    end
  end
end


RSpec.describe Recharge::HTTPRequest::Update do
  FooUpdate = Struct.new(:args) do
    extend Recharge::HTTPRequest::Update
  end

  FooUpdate::PATH = "/update"
  FooUpdate::SINGLE = "update"

  describe ".update" do
    it "makes a PUT request to PATH endpoint for the given id and data" do
      id = 123
      data = { :a => 123, :b => 456 }

      expect(FooUpdate).to receive(:PUT)
      	              .with(FooUpdate::PATH + "/#{id}", data)
                      .and_return({})

      expect(FooUpdate.update(id, data)).to eq FooUpdate.new
    end
  end
end
