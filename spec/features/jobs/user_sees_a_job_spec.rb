require 'rails_helper'

describe "User sees a specific job" do
  before :each do
    @category = Category.create(title: 'Finance')
    @company_1 = Company.create(name: "ESPN")
    @job_11 = @company_1.jobs.create(title: "Developer", level_of_interest: 70, city: "Denver", category_id: @category.id)
    @job_12 = @company_1.jobs.create(title: "QA Analyst", level_of_interest: 70, city: "New York City", category_id: @category.id)
    @company_2 = Company.create(name: "Apple")
    @job_21 = @company_2.jobs.create(title: "Manager", level_of_interest: 70, city: "Denver", category_id: @category.id)
  end
  scenario "a user sees a job for an unspecific company" do
    visit jobs_path
    click_link "#{@job_11.title}"
    expect(current_path).to eq("/jobs/#{@job_11.id}")

    expect(page).to have_content("ESPN")
    expect(page).to have_content("Developer")
    expect(page).to have_content("70")
  end
  scenario "a user sees a job for a specific company" do
    visit company_path(@company_1)
    click_link 'Jobs'
    click_link "#{@job_11.title}"
    expect(current_path).to eq("/companies/#{@company_1.id}/jobs/#{@job_11.id}")

    expect(page).to have_content("ESPN")
    expect(page).to have_content("Developer")
    expect(page).to have_content("70")
  end
end
