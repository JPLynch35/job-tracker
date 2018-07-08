require 'rails_helper'

describe Job do
  describe "validations" do
    context "invalid attributes" do
      before :each do
        @category = Category.create(title: 'Finance')
        @company = Company.create(name: "ESPN")
      end
      it "is invalid without a title" do
        job = Job.new(level_of_interest: 80, description: "Wahoo", level_of_interest: 40, city: "Denver", company_id: @company.id,category_id: @category.id)
        expect(job).to be_invalid
      end

      it "is invalid without a level of interest" do
        job = Job.new(title: "Developer", description: "Wahoo", city: "Denver", company_id: @company.id, category_id: @category.id)
        expect(job).to be_invalid
      end

      it "is invalid without a city" do
        job = Job.new(title: "Developer", description: "Wahoo", level_of_interest: 80, company_id: @company.id, category_id: @category.id)
        expect(job).to be_invalid
      end

      it "is invalid without a company" do
        job = Job.new(title: "Developer", description: "Wahoo", level_of_interest: 40, city: "Denver", category_id: @category.id)
        expect(job).to be_invalid
      end

      it "is invalid without a category" do
        job = Job.new(title: "Developer", description: "Wahoo", level_of_interest: 40, company_id: @company.id, city: "Denver")
        expect(job).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a title, level of interest, company, and category" do
        category = Category.create(title: 'Finance')
        company = Company.create(name: "Turing")
        job = company.jobs.create(title: "Developer", level_of_interest: 40, city: "Denver", category_id: category.id)
        expect(job).to be_valid
      end
    end
  end

  describe "relationships" do
    it "belongs to a company" do
      category = Category.create(title: 'Finance')
      company = Company.create(name: "Turing")
      job = company.jobs.create(title: "Developer", level_of_interest: 40, city: "Denver", category_id: category.id)
      expect(job).to respond_to(:company)
    end
  end
end
