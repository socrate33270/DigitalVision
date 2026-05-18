class OfferPlan
  attr_reader :slug, :badge, :name, :description, :price, :billing_detail, :price_context,
              :theme, :included_features, :excluded_features, :cta_label, :engagement,
              :featured_label, :footer_note

  def initialize(slug:, badge:, name:, description:, price:, theme:, included_features:,
                 billing_detail: nil, price_context: nil, excluded_features: [],
                 cta_label: "Parler de cette offre", engagement: nil, featured: false,
                 featured_label: "Recommande", footer_note: nil, pricing: :recurring)
    @slug = slug
    @badge = badge
    @name = name
    @description = description
    @price = price
    @billing_detail = billing_detail
    @price_context = price_context
    @theme = theme
    @included_features = included_features
    @excluded_features = excluded_features
    @cta_label = cta_label
    @engagement = engagement
    @featured = featured
    @featured_label = featured_label
    @footer_note = footer_note
    @pricing = pricing
  end

  def featured?
    @featured
  end

  def recurring?
    @pricing == :recurring
  end

  def one_time?
    @pricing == :one_time
  end

  def quote?
    @pricing == :quote
  end
end
