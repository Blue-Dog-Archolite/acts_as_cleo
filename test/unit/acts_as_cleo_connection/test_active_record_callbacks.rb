require "#{File.dirname(File.expand_path(__FILE__))}/../../helper"

class TestActiveRecordCallbacHooks < Test::Unit::TestCase
  def setup
    @author = Author.create(:name => "Von Himler")
    @book = Book.create(:name => "Rise and Fall", :author => @author)
  end

  should "have callbacks functioning properly" do
    category = Category.new(:name => "Sweetness")
    category.book = @book
    category.author = @author

    assert_nothing_raised do
      category.save!
    end

    book = Book.create(:name => "Fall and Rise", :author => @author)
    category.book = book

    assert_nothing_raised do
      category.save!
    end

#    assert_nothing_raised do
      category.destroy
#    end
  end
end
