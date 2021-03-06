require "#{File.dirname(File.expand_path(__FILE__))}/../../helper"

class TestModelToCleo < Test::Unit::TestCase
  should "convert from model to cleo result" do
    b = Book.new(:name => "Suncrusher", :author => Author.create(:name => "Tad Williams"))
    assert b.respond_to?("as_cleo")
    assert b.respond_to?("to_cleo_result")

    cb = nil
    assert_nothing_raised do
      cb = b.as_cleo
    end

    assert_equal cb.name, b.name.downcase
    assert_equal cb.score, b.cleo_score
    assert_equal 2, cb.terms.count
  end
end
