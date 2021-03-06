class ContactsController < ApplicationController
  def create
    @contact = Contact.new(contact_params)
    @contact.company_id = params[:company_id]

    @contact.save

    redirect_to company_path(params[:company_id])
  end

  def destroy
    @contact = Contact.includes(:company).find(params[:id])
    @company = @contact.company
    @contact.destroy

    flash[:success] = "#{@contact.name} was successfully deleted!"
    redirect_to company_path(@company)
  end

  private
    def contact_params
      params.require(:contact).permit(:name, :role, :email)
    end
end
