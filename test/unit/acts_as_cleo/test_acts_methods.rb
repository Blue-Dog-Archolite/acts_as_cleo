require "#{File.dirname(File.expand_path(__FILE__))}/../../helper"

#Literally checking that the acts_as_cleo tag takes args and sets them as expected
class TestActsAsMethods < Test::Unit::TestCase

  should "respond to and return as_cleo" do
    book = Book.new(:name => 'Wedge\'s Life', :author => Author.create(:name => "Luke Skywalker"))
    assert_equal %w{name author}, book.cleo_config[:terms]
    assert_equal "name", book.cleo_config[:name]
    assert_equal "Book", book.cleo_config[:type]
  end

  should "exclude terms by default" do
    movie = Movie.create(:name => "A New Hope", :description => "The Best")
    assert_equal %w{name description}, movie.cleo_config[:terms]
    assert_equal "id", movie.cleo_config[:score]
    assert_equal "name", movie.cleo_config[:name]
  end
end
