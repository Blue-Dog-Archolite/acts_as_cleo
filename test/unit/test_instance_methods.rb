require 'helper'

class TestInstanceMethods < Test::Unit::TestCase
  def setup
    @b = Book.new
  end
  %w{cleo_id cleo_id= sync_with_cleo set_cleo_id remove_from_cleo to_cleo_result as_cleo}.each do |resp|
    should "respond to cleo_id and cleo_id=" do
      assert @b.respond_to?(resp), "ActiveRecord Model with acts_as_cleo should respond to #{resp}"
    end
  end
end
