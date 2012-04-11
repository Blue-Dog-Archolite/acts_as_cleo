require 'helper'

class TestModelToCleo < Test::Unit::TestCase
  should "convert from model to cleo result" do
    b = Book.new(:name => "Suncrusher", :author => "Tad Williams")
    assert b.respond_to?("as_cleo")
    assert b.respond_to?("to_cleo_result")

    cb = nil
    assert_nothing_raised do
      cb = b.as_cleo
    end

    assert_equal cb.name, b.name.downcase
    assert_equal cb.score, b.cleo_score
    assert_equal 3, cb.terms.count
  end
end
