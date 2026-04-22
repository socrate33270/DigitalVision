class Contact < ApplicationRecord
  SERVICE_TYPES = [
    "Marketing Réseaux Sociaux",
    "Création Web/Mobile",
    "Automatisation IA",
    "Formation IA"
  ].freeze

  enum :status, {
    en_attente: 0,
    repondu: 1,
    valide: 2,
    perdu: 3
  }, default: :en_attente

  STATUS_LABELS = {
    "en_attente" => "En attente",
    "repondu" => "Répondu",
    "valide" => "Validé",
    "perdu" => "Perdu"
  }.freeze

  validates :full_name, :email, :message, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :service_type, inclusion: { in: SERVICE_TYPES }, allow_blank: true

  scope :unread, -> { where(read: false) }

  def self.status_options_for_select
    statuses.keys.map { |status| [ STATUS_LABELS.fetch(status), status ] }
  end

  def status_label
    STATUS_LABELS.fetch(status)
  end

  def status_dom_id
    "contacts_list_#{status}"
  end
end
