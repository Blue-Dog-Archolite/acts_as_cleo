require 'helper'

class TestInstanceMethods < Test::Unit::TestCase
  def setup
    @b = Book.new
  end

  %w{cleo_id update_cleo remove_from_cleo create_cleo set_cleo_id to_cleo_result as_cleo}.each do |resp|
    should "respond to #{resp}" do
      assert @b.respond_to?(resp), "ActiveRecord Model with acts_as_cleo should respond to #{resp}"
    end
  end

  #TODO write tests for the functionality of each of the instance methods
end
