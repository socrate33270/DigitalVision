require "test_helper"

class ContactsControllerTest < ActionDispatch::IntegrationTest
  test "creates contact and redirects" do
    assert_difference("Contact.count", 1) do
      post contacts_url, params: {
        contact: {
          full_name: "Jean Dupont",
          email: "jean@example.com",
          service_type: "Automatisation IA",
          message: "Je souhaite automatiser mon acquisition."
        }
      }
    end

    assert_redirected_to root_path(anchor: "contact")
  end

  test "does not create invalid contact" do
    assert_no_difference("Contact.count") do
      post contacts_url, params: { contact: { full_name: "", email: "bad", message: "" } }
    end

    assert_response :unprocessable_entity
  end
end
