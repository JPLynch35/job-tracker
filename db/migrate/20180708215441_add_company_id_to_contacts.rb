class AddCompanyIdToContacts < ActiveRecord::Migration[5.1]
  def change
    add_reference :contacts, :company, index: true, foreign_key: true
  end
end
