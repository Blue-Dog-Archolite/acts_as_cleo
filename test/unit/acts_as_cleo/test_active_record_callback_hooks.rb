require "#{File.dirname(File.expand_path(__FILE__))}/../../helper"

class TestActiveRecordCallbacHooks < Test::Unit::TestCase
  should "have all callbacks functioning properly" do
    book = Book.new(:name => "set cleo id", :author => "Rob Meyer")
    assert_nil book.cleo_id
    assert_nil Cleo::Element.find(:first, :conditions => ["record_type = ? and record_id = ?", "Book", book.id])

    assert book.save!
    book_id = book.id

    assert book.cleo_id
    ref = Cleo::Element.find(:first, :conditions => ["record_type = ? and record_id = ?", "Book", book_id])
    assert_not_nil ref

    assert book.destroy
    assert_nil Cleo::Element.find(:first, :conditions => ["record_type = ? and record_id = ?", "Book", book_id])
    assert_nil Cleo::ElementServer.find(ref.id)
  end

  should "update cleo on record update" do
    book = Book.new(:name => "update cleo", :author => "Rob Meyer")
    assert book.save!
    cleo_record = Cleo::ElementServer.find(book.cleo_id)
    assert_not_nil cleo_record
    book.name = "Updated my Cleo"
    assert book.save!

    updated_cleo_record = Cleo::ElementServer.find(book.cleo_id)
    assert_equal book.name.downcase, updated_cleo_record.name
    assert_not_equal cleo_record.name, updated_cleo_record.name

    assert book.destroy
  end
end
