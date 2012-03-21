require 'helper'

class TestCommonMethods < Test::Unit::TestCase
  should "respond to query call" do
    assert Book.respond_to?("query")
  end

  should "find record with book name" do
    book = Book.create(:name => "Otherland", :author => "Tad Williams")
    assert Cleo.create(book)
    book_cleo_id = book.cleo_id
    assert Cleo.find(book_cleo_id)

    require 'ruby-debug'
    debugger

    assert Cleo.delete(book_cleo_id)
    assert_nil Cleo.find(book_cleo_id)
  end
end

