class ContactsController < ApplicationController
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.turbo_stream do
          flash.now[:notice] = "Merci, votre demande a bien été envoyée. Nous revenons vers vous rapidement."
          render turbo_stream: [
            turbo_stream.replace("flash", partial: "layouts/flash"),
            turbo_stream.replace("contact_form", partial: "pages/partials/contact_form", locals: { contact: Contact.new })
          ]
        end

        format.html do
          redirect_to root_path(anchor: "contact"), notice: "Merci, votre demande a bien été envoyée. Nous revenons vers vous rapidement."
        end
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "contact_form",
            partial: "pages/partials/contact_form",
            locals: { contact: @contact }
          ), status: :unprocessable_entity
        end

        format.html do
          load_homepage
          flash.now[:alert] = "Veuillez corriger les champs indiqués."
          render "pages/home", status: :unprocessable_entity
        end
      end
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:full_name, :email, :service_type, :message)
  end

  def load_homepage
    homepage = HomepageContent.new
    @services = homepage.services
    @ai_solutions = homepage.ai_solutions
    @formations = homepage.formations
  end
end
