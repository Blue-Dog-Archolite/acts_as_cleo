require 'helper'

class TestCleo < Test::Unit::TestCase
  def setup
    file = File.open("#{Dir.pwd}/test/data/xml/cleo/testing_element.xml")
    contents = file.read
    @wedge = Cleo::Result.parse(contents, :singluar => true)
  end

  should "create then destroy Testing Object " do
    code = Cleo.create(@wedge)
    assert code

    wa = Cleo.find(@wedge.id)
    assert_not_nil wa
    assert_equal @wedge.id, wa.id

    assert Cleo.delete(wa.id), "Didn't delete"
  end

  should "get google results from qery" do
    r = Cleo.query("goog")
    assert_not_nil r
    assert_equal 0, r.count
    assert_kind_of Array, r
  end

=begin
This is a bad test and require default value to be in Cleo. Baddd test
  should "fetch the same record by id" do
    r = Cleo.query("goog").first
    assert_equal r.id.blank?, false


    i = Cleo.find(r.id)
    assert_equal r.timestamp, i.timestamp
    assert_equal r.id, i.id
  end
=end

  should "create, update, then destroy, Testing Object" do
    code = Cleo.create(@wedge)
    assert code

    wa = Cleo.find(@wedge.id)
    assert_not_nil wa
    assert_equal @wedge.id, wa.id

    wa.name = "Luke Skywalker"
    assert Cleo.update(wa)

    wa_update = Cleo.find(@wedge.id)
    assert_equal "Luke Skywalker", wa_update.name

    assert Cleo.delete(wa.id), "didn't delete"
  end

  should "change the configuration of the server" do
    server_config = {:url => "http://localhost:8080/cleo-primer/", :run_async => true, :queue => "cleo"}

    Cleo::Server.configure server_config
    assert Cleo::Server.async?
    assert "cleo", Cleo::Server.queue.to_s


    server_config = {:url => "http://localhost:8080/cleo-primer/", :run_async => false}
    Cleo::Server.configure server_config
    assert_same false, Cleo::Server.async?
    assert "cleo", Cleo::Server.queue.to_s
  end
end

