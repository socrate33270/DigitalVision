module Admin
  class ContactsController < BaseController
    before_action :set_contact, only: :update
    before_action :load_board, only: :index

    def index
      respond_to do |format|
        format.html
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "contacts_board",
            partial: "admin/contacts/board",
            locals: board_locals
          )
        end
      end
    end

    def update
      previous_status = @contact.status

      if @contact.update(contact_params)
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: update_streams(previous_status)
          end
          format.html { redirect_to admin_contacts_path, notice: "Statut mis à jour." }
        end
      else
        redirect_to admin_contacts_path, alert: "Impossible de mettre à jour ce contact."
      end
    end

    private

    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(:status)
    end

    def load_board
      @statuses = Contact.statuses.keys
      @contacts_by_status = @statuses.index_with do |status|
        Contact.public_send(status).order(created_at: :desc)
      end
      @status_counts = status_counts
    end

    def board_locals
      {
        statuses: @statuses,
        contacts_by_status: @contacts_by_status,
        status_counts: @status_counts
      }
    end

    def status_counts
      Contact.statuses.keys.index_with { |status| Contact.public_send(status).count }
    end

    def update_streams(previous_status)
      statuses_to_refresh = [ previous_status, @contact.status ].uniq
      streams = [
        turbo_stream.remove(@contact),
        turbo_stream.prepend(@contact.status_dom_id, partial: "admin/contacts/contact", locals: { contact: @contact })
      ]

      statuses_to_refresh.each do |status|
        streams << turbo_stream.replace(
          "contacts_count_#{status}",
          partial: "admin/contacts/status_count",
          locals: { status:, count: Contact.public_send(status).count }
        )
      end

      streams
    end
  end
end
