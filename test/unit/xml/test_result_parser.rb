require "#{File.dirname(File.expand_path(__FILE__))}/../../helper"

class TestResult < Test::Unit::TestCase
  def test_parser_gets_correct_element
    file = File.open("#{Dir.pwd}/test/data/xml/cleo/element.xml")
    contents = file.read
    cr = Cleo::Xml::Result.parse(contents, :singluar => true)

    assert_not_equal cr, nil
    assert_equal cr.name, "Cleo Inc."
  end

  def test_parser_gets_many_elements
    file = File.open("#{Dir.pwd}/test/data/xml/cleo/elements.xml")
    contents = file.read
    cr = Cleo::Xml::Result.parse(contents)

    assert_equal 7, cr.count
    assert_match /google/i, cr.first.name
    assert_equal cr.first.terms, %w{google inc. goog}
  end
end

