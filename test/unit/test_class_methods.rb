require 'helper'

class TestClassMethods < Test::Unit::TestCase
  should "respond to query call" do
    assert Book.respond_to?("query")
  end

  should "find record with book name" do
    book = Book.create(:name => "Otherland", :author => "Tad Williams")
    assert Cleo.create(book)
    book_cleo_id = book.cleo_id
    assert Cleo.find(book_cleo_id)

    assert Cleo.delete(book_cleo_id)
  end

  should "be able to query from Klass" do
    books = Book.query("goog")
    assert_not_nil books
    assert_kind_of Array, books
  end
end
