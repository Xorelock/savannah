require 'test_helper'
require 'lib/aies'

class ClientsControllerTest < ActionController::TestCase

  def setup
    @controller.instance_eval do
      @server = Aies::Server.new
    end
  end

  test "begin with an empty client list" do
    result = get :index
    assert_equal "200", result.code
    assert_equal [], ActiveSupport::JSON.decode(result.body)
  end

  test "adding clients results in a populated list" do
    result = post :create, {:client=>{:name=>"foobar"}}
    assert_equal "201", result.code, result.body
    uuid1 = ActiveSupport::JSON.decode(result.body)["uuid"]
    result = get :index
    assert_equal "200", result.code
    assert_equal [{"name"=>"foobar","uuid" => uuid1}], ActiveSupport::JSON.decode(result.body)

    result = post :create, {:client=>{:name=>"foobaz"}}
    assert_equal "201", result.code, result.body
    uuid2 = ActiveSupport::JSON.decode(result.body)["uuid"]
    result = get :index
    assert_equal "200", result.code
    assert_equal [{"name"=>"foobar","uuid" => uuid1},{"name"=>"foobaz","uuid" => uuid2}], ActiveSupport::JSON.decode(result.body).sort { |a,b| a["name"] <=> b["name"] }
  end

  test "adding the same client twice yields an error" do
    result = post :create, {:client=>{:name=>"foobar"}}
    assert_equal "201", result.code, result.body

    result = post :create, {:client=>{:name=>"foobar"}}
    assert_equal "409", result.code, result.body
  end

  test "creating client yields a showable resource" do
    result = post :create, {:client=>{:name => "foobar"}}
    assert_response :created
    uuid = ActiveSupport::JSON.decode(result.body)["uuid"]

    result = get :show, {:id => uuid }
    assert_response :ok
    #json = ActiveSupport::JSON.decode(result.body)
    assert_equal({"name"=>"foobar","uuid"=>uuid}, ActiveSupport::JSON.decode(result.body))
    #assert_equal "foobar", json["name"]
    #assert_equal uuid, json["uuid"]
  end
end
