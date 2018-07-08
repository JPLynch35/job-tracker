require 'rails_helper'

describe "User sees all jobs" do
  before :each do
    @category = Category.create(title: 'Finance')
    @company_1 = Company.create(name: "ESPN")
    @company_1.jobs.create(title: "Developer", level_of_interest: 70, city: "Denver", category_id: @category.id)
    @company_1.jobs.create(title: "QA Analyst", level_of_interest: 70, city: "New York City", category_id: @category.id)
    @company_2 = Company.create(name: "Apple")
    @company_2.jobs.create(title: "Manager", level_of_interest: 70, city: "Denver", category_id: @category.id)
  end
  scenario "a user sees all jobs" do
    visit jobs_path

    expect(page).to have_content("Developer")
    expect(page).to have_content("QA Analyst")
    expect(page).to have_content("Manager")
  end
  scenario "a user sees all the jobs for a specific company" do
    visit company_jobs_path(@company_1)

    expect(page).to have_content("ESPN")
    expect(page).to have_content("Developer")
    expect(page).to have_content("QA Analyst")
  end
end
