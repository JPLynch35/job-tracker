require 'rails_helper'

describe Contact do
  describe "validations" do
    context "invalid attributes" do
      before :each do
        @company = Company.create(name: "ESPN")
      end
      it "is invalid without a name" do
        contact = Contact.new(name: nil, role: "Manager", email: "chris@espn.com", company_id: @company.id)
        expect(contact).to be_invalid
      end

      it "is invalid without a role" do
        contact = Contact.new(name: "Chris Camp", role: nil, email: "chris@espn.com", company_id: @company.id)
        expect(contact).to be_invalid
      end

      it "is invalid without an email" do
        contact = Contact.new(name: "Chris Camp", role: "Manager", email: nil, company_id: @company.id)
        expect(contact).to be_invalid
      end

      it "is invalid without a company" do
        contact = Contact.new(name: "Chris Camp", role: "Manager", email: "chris@espn.com", company_id: nil)
        expect(contact).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a name, role, email, and company" do
        company = Company.create(name: "Turing")
        contact = company.contacts.create(name: "Chris Camp", role: "Manager", email: "chris@espn.com")
        expect(contact).to be_valid
      end
    end
  end

  describe "relationships" do
    it "belongs to a company" do
      company = Company.create(name: "Turing")
      contact = company.contacts.create(name: "Chris Camp", role: "Manager", email: "chris@turing.com")
      expect(contact).to respond_to(:company)
    end
  end
end
