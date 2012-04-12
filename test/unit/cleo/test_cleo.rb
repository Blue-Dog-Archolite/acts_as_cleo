require "#{File.dirname(File.expand_path(__FILE__))}/../../helper"

class TestCleo < Test::Unit::TestCase
  def setup
    file = File.open("#{Dir.pwd}/test/data/xml/cleo/testing_element.xml")
    contents = file.read
    @wedge = Cleo::Xml::Result.parse(contents, :singluar => true)
  end

  should "create then destroy Testing Object " do
    code = Cleo::ElementServer.create(@wedge)
    assert code

    wa = Cleo::ElementServer.find(@wedge.id)
    assert_not_nil wa
    assert_equal @wedge.id, wa.id

    assert Cleo::ElementServer.delete(wa.id), "Didn't delete"
  end

  should "create, update, then destroy, Testing Object" do
    code = Cleo::ElementServer.create(@wedge)
    assert code

    wa = Cleo::ElementServer.find(@wedge.id)
    assert_not_nil wa
    assert_equal @wedge.id, wa.id

    wa.name = "Luke Skywalker"
    assert Cleo::ElementServer.update(wa)

    wa_update = Cleo::ElementServer.find(@wedge.id)
    assert_equal "Luke Skywalker", wa_update.name

    assert Cleo::ElementServer.delete(wa.id), "didn't delete"
  end

  should "change the configuration of the server" do
    server_config = {:url => "http://localhost:8080/cleo-primer/", :run_async => true, :queue => "cleo"}

    Cleo.configure server_config
    assert Cleo::Service.async?
    assert "cleo", Cleo::Service.queue.to_s


    server_config = {:url => "http://localhost:8080/cleo-primer/", :run_async => false}
    Cleo.configure server_config
    assert_same false, Cleo::Service.async?
    assert "cleo", Cleo::Service.queue.to_s
  end
end
