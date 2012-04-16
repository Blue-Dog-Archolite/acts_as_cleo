require "#{File.dirname(File.expand_path(__FILE__))}/../../helper"

class TestActiveRecordCallbacHooks < Test::Unit::TestCase
  def setup
    @book = Book.create(:name => "Otherland book 1")
    @author = Author.create(:name => "Tad Williams")
    @con = Category.new(:book => @book, :author => @author)
  end

  should "have acts_as_cleo_connection hooks and respond to them as expected" do
    con = Category.new(:book => @book, :author => @author)

    assert_not_nil con.book
    assert_not_nil con.author
    assert_equal con.author, @author
    assert_equal con.book, @book

    assert con.respond_to?(:cleo_target)
    assert con.respond_to?(:cleo_origin)
    assert con.respond_to?(:cleo_type)

    assert con.respond_to?(:to_cleo_connection)
    assert con.respond_to?(:as_connection)

    assert con.respond_to?(:create_cleo_connection)
    assert con.respond_to?(:update_cleo_connection)
    assert con.respond_to?(:remove_cleo_connection)

    assert_equal con.cleo_origin, "book"
    assert_equal con.cleo_target, "author"
    assert_equal con.cleo_type, "call_for_type_method"
  end
end
