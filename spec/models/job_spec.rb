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

  describe "class methods" do
    it "self.job_interests can calculate the number of jobs for each interest level" do
      @category = Category.create(title: 'Finance')
      @company_1 = Company.create(name: "ESPN")
      @job_1 = @company_1.jobs.create(title: "Developer", level_of_interest: 2, city: "Denver", category_id: @category.id)
      @job_2 = @company_1.jobs.create(title: "QA Analyst", level_of_interest: 2, city: "New York City", category_id: @category.id)
      @job_3 = @company_1.jobs.create(title: "Manager1", level_of_interest: 4, city: "Denver", category_id: @category.id)
      @job_4 = @company_1.jobs.create(title: "Manager2", level_of_interest: 4, city: "Denver", category_id: @category.id)
      @job_5 = @company_1.jobs.create(title: "Manager3", level_of_interest: 4, city: "Denver", category_id: @category.id)
      @job_6 = @company_1.jobs.create(title: "Manager4", level_of_interest: 4, city: "Denver", category_id: @category.id)
      @job_7 = @company_1.jobs.create(title: "Manager5", level_of_interest: 5, city: "Denver", category_id: @category.id)
      @job_8 = @company_1.jobs.create(title: "Manager6", level_of_interest: 5, city: "Denver", category_id: @category.id)
      @job_9 = @company_1.jobs.create(title: "Manager7", level_of_interest: 5, city: "Denver", category_id: @category.id)

      expected = {
        5 => 3,
        4 => 4,
        2 => 2
      }

      expect(Job.job_interests).to eq(expected)
    end
    it "self.top_companies_by_interest can calculate the average level of interest for top 3 companies" do
      @category = Category.create(title: 'Finance')
      @company_1 = Company.create(name: "ESPN")
      @job_1 = @company_1.jobs.create(title: "Developer", level_of_interest: 2, city: "Denver", category_id: @category.id)
      @job_2 = @company_1.jobs.create(title: "QA Analyst", level_of_interest: 2, city: "New York City", category_id: @category.id)
      @job_3 = @company_1.jobs.create(title: "Manager1", level_of_interest: 4, city: "Denver", category_id: @category.id)
      @job_4 = @company_1.jobs.create(title: "Manager2", level_of_interest: 4, city: "Denver", category_id: @category.id)
      @job_5 = @company_1.jobs.create(title: "Manager3", level_of_interest: 4, city: "Denver", category_id: @category.id)
      @job_6 = @company_1.jobs.create(title: "Manager4", level_of_interest: 4, city: "Denver", category_id: @category.id)
      @job_7 = @company_1.jobs.create(title: "Manager5", level_of_interest: 5, city: "Denver", category_id: @category.id)
      @job_8 = @company_1.jobs.create(title: "Manager6", level_of_interest: 5, city: "Denver", category_id: @category.id)
      @job_9 = @company_1.jobs.create(title: "Manager7", level_of_interest: 5, city: "Denver", category_id: @category.id)

      array = Job.top_companies_by_interest

      expect(array.first.name).to eq('IBM')
      expect(array[1].name).to eq('Apple')
      expect(array.last.name).to eq('ESPN')
    end
  end
end
