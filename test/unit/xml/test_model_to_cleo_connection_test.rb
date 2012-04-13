require "#{File.dirname(File.expand_path(__FILE__))}/../../helper"

class TestModelToCleoConnection < Test::Unit::TestCase
  def setup
    @book = Book.create(:name => "Otherland book 1")
    @author = Author.create(:name => "Tad Williams")
    @con = Category.new(:name => "SiFi", :book => @book, :author => @author)
  end

  should "convert from model to cleo connection" do
    assert @con.respond_to?(:cleo_target)
    assert @con.respond_to?(:cleo_origin)

    assert @con.respond_to?(:to_cleo_connection)
    assert @con.respond_to?(:as_connection)

    cb = nil
    assert_nothing_raised do
      cb = @con.as_connection
    end

    assert_equal cb.target, @con.send("#{@con.cleo_target}").cleo_id
    assert_equal cb.source, @con.send("#{@con.cleo_origin}").cleo_id

    cb = nil
    assert_nothing_raised do
      cb = @con.to_cleo_connection
    end

    assert_equal cb.target, @con.send("#{@con.cleo_target}").cleo_id
    assert_equal cb.source, @con.send("#{@con.cleo_origin}").cleo_id
  end
end
