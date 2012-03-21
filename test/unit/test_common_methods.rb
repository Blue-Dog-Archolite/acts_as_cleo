require 'helper'

class TestCommonMethods < Test::Unit::TestCase
  should "respond to query call" do
    assert Book.respond_to?("query")
  end
end
