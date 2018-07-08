require 'rails_helper'

describe "A User" do
  before :each do
    @category_1 = Category.create(title: "Finance")
    @category_2 = Category.create(title: "Definitely Not Finance")
    @company_1 = Company.create(name: "ESPN")
    @job_11 = @company_1.jobs.create(title: "Developer", level_of_interest: 4, city: "Denver", category_id: @category_1.id)
    @job_12 = @company_1.jobs.create(title: "QA Analyst", level_of_interest: 3, city: "New York City", category_id: @category_2.id)
    @company_2 = Company.create(name: "Apple")
    @job_21 = @company_2.jobs.create(title: "Manager", level_of_interest: 2, city: "Denver", category_id: @category_1.id)
    @job_22 = @company_2.jobs.create(title: "Thug", level_of_interest: 1, city: "Orlando", category_id: @category_1.id)
  end
  scenario "sees all jobs sorted by City" do
    visit "/jobs?sort=location"


    expect(@job_11.title).to appear_before(@job_12.title)
    expect(@job_21.title).to appear_before(@job_12.title)
    expect(@job_12.title).to appear_before(@job_22.title)
  end
  scenario "sees all jobs sorted by level_of_interest" do
    visit "/jobs?sort=interest"


    expect(@job_22.title).to appear_before(@job_21.title)
    expect(@job_22.title).to appear_before(@job_12.title)
    expect(@job_21.title).to appear_before(@job_11.title)
  end
end
