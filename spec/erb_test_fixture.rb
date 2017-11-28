require "erb"

#
# Use ERB in your test fixtures and easily load them.
#
# By: Skye Shaw (https://github.com/sshaw)
# Date: 2016-06-30
# Source: https://gist.github.com/sshaw/f9bad743bb53d2439501d03fb6056a4c
#
# === Usage
#
# Include in your test suite:
#
# RSpec.configure { |c| c.include ERBTestFixture }
#
# Or:
#
# class Foo
#   include ERBTestFixture
#   ...
# end
#
# Create your fixture:
#
# {"name": "<%= @name %>", "city": "<%= @city %>"}
#
# Load your fixture in your test case:
#
# json = fixture("my_fixture", :name => "sshaw", :city => "XXX")
# json = fixture("my_fixture.json", ... ) # same as above
# json = fixture("subpath/my_fixture", :name => "fofinha")
#

module ERBTestFixture
  TEST_DIR = defined?(RSpec) ? "spec" : "test"
  FIXTURE_DIR = "fixtures"

  # From https://github.com/sshaw/itunes_store_transporter/blob/master/bin/itms
  Binding = Class.new do
    def initialize(options = {})
      options.each do |k, v|
        name = k.to_s.gsub(/[^\w]+/, "_")
        instance_variable_set("@#{name}", v)
      end
    end
  end

  def fixture(fixture, vars = {})
    unless File.file?(fixture)
      fixture = lookup_fixture(fixture)
      raise ArgumentError, "Fixture not found: #{fixture}" unless File.file?(fixture)
    end

    data = File.read(fixture)
    ERB.new(data).def_class(Binding).new(vars).result
  end

  private

  def lookup_fixture(fixture)
    if self.class.respond_to?(:fixture_path) && self.class.fixture_path
      fixture = File.join(fixture_path, fixture)
    else
      root = if defined?(Rails)
               Rails.root
             elsif defined?(Padrino)
               Padrino.root
             elsif defined?(Sinatra)
               Sinatra::Application.root
             else
               Dir.pwd
             end

      fixture = File.join(root, TEST_DIR, FIXTURE_DIR, fixture)
    end

    unless File.file?(fixture)
      files = Dir["#{fixture}.*"]
      # If there's more than one match then don't guess
      # caller must be more specific
      fixture = files.first if files.one?
    end

    fixture
  end
end
