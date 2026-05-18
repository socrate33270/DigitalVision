require "test_helper"

class OfferCatalogTest < ActiveSupport::TestCase
  test "exposes the expected offer collections" do
    catalog = OfferCatalog.new

    assert_equal 3, catalog.community_management_plans.size
    assert_equal 3, catalog.website_plans.size
    assert_equal 3, catalog.bundles.size
    assert_equal 10, catalog.comparison_rows.size
  end

  test "marks the duo pack as featured" do
    featured_plan = OfferCatalog.new.community_management_plans.find(&:featured?)

    assert_equal "Duo Reseaux", featured_plan.name
  end
end
