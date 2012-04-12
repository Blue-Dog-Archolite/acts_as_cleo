require "#{File.dirname(File.expand_path(__FILE__))}/../../helper"

class TestClassMethods < Test::Unit::TestCase
  should "respond to query call" do
    assert Book.respond_to?("query")
  end

  should "find record with book name" do
    book = Book.create(:name => "Otherland", :author => "Tad Williams")
    assert Cleo::ElementServer.create(book)
    book_cleo_id = book.cleo_id
    assert Cleo::ElementServer.find(book_cleo_id)

    assert Cleo::ElementServer.delete(book_cleo_id), "Didn't Delete"
  end

  should "be able to query from Klass" do
    books = Book.query("goog")
    assert_not_nil books
    assert_kind_of Array, books
  end
end
