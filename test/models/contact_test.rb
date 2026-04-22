require "test_helper"

class ContactTest < ActiveSupport::TestCase
  test "valid with required attributes" do
    contact = Contact.new(
      full_name: "Jean Dupont",
      email: "jean@example.com",
      service_type: "Création Web/Mobile",
      message: "Je souhaite créer un site vitrine."
    )

    assert contact.valid?
    assert_predicate contact, :en_attente?
  end

  test "requires full name email and message" do
    contact = Contact.new

    assert_not contact.valid?
    assert_includes contact.errors[:full_name], "can't be blank"
    assert_includes contact.errors[:email], "can't be blank"
    assert_includes contact.errors[:message], "can't be blank"
  end

  test "rejects invalid email" do
    contact = Contact.new(
      full_name: "Jean Dupont",
      email: "invalid-email",
      message: "Je souhaite créer un site vitrine."
    )

    assert_not contact.valid?
    assert_includes contact.errors[:email], "is invalid"
  end

  test "exposes status labels for admin kanban" do
    assert_equal "En attente", contacts(:one).status_label
    assert_includes Contact.status_options_for_select, [ "Répondu", "repondu" ]
  end
end
