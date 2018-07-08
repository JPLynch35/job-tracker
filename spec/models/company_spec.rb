require 'rails_helper'

describe Company do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a name" do
        company = Company.new()
        expect(company).to be_invalid
      end

      it "has a unique name" do
        Company.create(name: "Dropbox")
        company = Company.new(name: "Dropbox")
        expect(company).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a name" do
        company = Company.new(name: "Dropbox")
        expect(company).to be_valid
      end
    end
  end

  describe "relationships" do
    it "has many jobs" do
      company = Company.new(name: "Dropbox")
      expect(company).to respond_to(:jobs)
    end
  end

  describe 'class methods' do
    it "self.top_companies_by_interest can calculate the average level of interest for top 3 companies" do
      @category = Category.create(title: 'Finance')
      @company_1 = Company.create(name: "ESPN")
      @company_2 = Company.create(name: "Apple")
      @company_3 = Company.create(name: "IBM")
      @job_1 = @company_1.jobs.create(title: "Developer", level_of_interest: 2, city: "Denver", category_id: @category.id)
      @job_2 = @company_2.jobs.create(title: "QA Analyst", level_of_interest: 2, city: "New York City", category_id: @category.id)
      @job_3 = @company_1.jobs.create(title: "Manager1", level_of_interest: 4, city: "Denver", category_id: @category.id)
      @job_4 = @company_2.jobs.create(title: "Manager2", level_of_interest: 4, city: "Denver", category_id: @category.id)
      @job_5 = @company_3.jobs.create(title: "Manager3", level_of_interest: 4, city: "Denver", category_id: @category.id)
      @job_6 = @company_2.jobs.create(title: "Manager4", level_of_interest: 4, city: "Denver", category_id: @category.id)
      @job_7 = @company_3.jobs.create(title: "Manager5", level_of_interest: 5, city: "Denver", category_id: @category.id)
      @job_8 = @company_3.jobs.create(title: "Manager6", level_of_interest: 5, city: "Denver", category_id: @category.id)
      @job_9 = @company_3.jobs.create(title: "Manager7", level_of_interest: 5, city: "Denver", category_id: @category.id)

      array = Company.top_companies_by_interest

      expect(array.first.name).to eq('IBM')
      expect(array[1].name).to eq('Apple')
      expect(array.last.name).to eq('ESPN')
    end
  end
end
