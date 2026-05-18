class OfferBundle
  attr_reader :title, :description, :discounted_price, :original_price, :details

  def initialize(title:, description:, discounted_price:, original_price:, details:)
    @title = title
    @description = description
    @discounted_price = discounted_price
    @original_price = original_price
    @details = details
  end
end
