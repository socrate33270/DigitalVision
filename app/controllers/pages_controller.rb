class PagesController < ApplicationController
  def home
    load_homepage
    @contact = Contact.new
  end

  private

  def load_homepage
    homepage = HomepageContent.new
    @services = homepage.services
    @ai_solutions = homepage.ai_solutions
    @formations = homepage.formations
  end
end
