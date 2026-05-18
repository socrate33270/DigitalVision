require "test_helper"

class OffersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get offers_url

    assert_response :success
    assert_select "h1", text: /Nos offres/
    assert_select "h2", text: /Gestion des reseaux sociaux/
    assert_select "h2", text: /Creation de sites/
  end
end
