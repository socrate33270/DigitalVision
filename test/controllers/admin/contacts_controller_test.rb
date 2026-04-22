require "test_helper"

module Admin
  class ContactsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @admin_user = admin_users(:one)
      @contact = contacts(:one)
    end

    test "redirects anonymous visitors to admin login" do
      get admin_contacts_url

      assert_redirected_to new_admin_user_session_path
    end

    test "admin can view kanban" do
      sign_in @admin_user

      get admin_contacts_url

      assert_response :success
      assert_select "#contacts_list_en_attente"
      assert_select "h1", text: /Gestion des leads entrants/
    end

    test "admin can refresh the board with turbo stream polling" do
      sign_in @admin_user

      get admin_contacts_url(format: :turbo_stream)

      assert_response :success
      assert_includes response.body, "turbo-stream"
      assert_includes response.body, "contacts_board"
    end

    test "admin can update contact status with turbo stream" do
      sign_in @admin_user

      patch admin_contact_url(@contact),
            params: { contact: { status: "repondu" } },
            headers: { "Accept" => "text/vnd.turbo-stream.html" }

      assert_response :success
      assert_predicate @contact.reload, :repondu?
      assert_includes response.body, "contacts_list_repondu"
    end

    test "admin sign in redirects to admin dashboard" do
      post admin_user_session_url, params: {
        admin_user: {
          email: @admin_user.email,
          password: "password123"
        }
      }

      assert_redirected_to admin_root_path
    end
  end
end
