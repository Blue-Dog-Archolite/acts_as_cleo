require 'helper'

class TestCleo < Test::Unit::TestCase
  def setup
    file = File.open("#{Dir.pwd}/test/data/xml/cleo/testing_element.xml")
    contents = file.read
    @wedge = Cleo::Result.parse(contents, :singluar => true)
  end

  should "get HTTP Connection" do
    net = Cleo.net_http
    assert_not_equal nil, net
  end

  should "create Testing Object" do
    code = Cleo.create(@wedge)
    assert code

    wa = Cleo.find(@wedge.id)
    assert_not_nil wa
    assert_equal @wedge.id, wa.id

    assert Cleo.delete(wa)
  end

  should "get google results from qery" do
    r = Cleo.query("goog")
    assert_not_nil r
    assert_equal 1, r.count
    assert_kind_of Array, r
  end

  should "fetch the same record by id" do
    r = Cleo.query("goog").first
    assert_equal r.id.blank?, false


    i = Cleo.find(r.id)
    assert_equal r.timestamp, i.timestamp
    assert_equal r.id, i.id
  end

#  should "destroy Testing Object" do
#    code = Cleo.delete(@wedge)
#    assert code
#  end

  should "update and then reset stored cleo object" do
  end
end

