class OffersController < ApplicationController
  def index
    @catalog = OfferCatalog.new
  end
end
