require 'rails_helper'

describe "User deletes existing job" do
  before :each do
    @category = Category.create(title: 'Finance')
    @company_1 = Company.create(name: "ESPN")
    @job_11 = @company_1.jobs.create(title: "Developer", level_of_interest: 1, city: "Denver", category_id: @category.id)
    @job_12 = @company_1.jobs.create(title: "QA Analyst", level_of_interest: 4, city: "New York City", category_id: @category.id)
    @company_2 = Company.create(name: "Apple")
    @job_21 = @company_2.jobs.create(title: "Manager", level_of_interest: 3, city: "Denver", category_id: @category.id)
  end
  scenario "a user can delete a job" do
    visit job_path(@job_12)

    click_link "Delete"

    expect(current_path).to eq ("/jobs")
    expect(page).to have_content("#{@job_11.title}")
    expect(page).to have_content("#{@job_12.title} was successfully deleted!")
  end
  scenario "a user can delete a job for a specific company" do
    visit company_job_path(@company_1, @job_12)

    click_link "Delete"

    expect(current_path).to eq ("/companies/#{@company_1.id}/jobs")
    expect(page).to have_content("#{@job_11.title}")
    expect(page).to have_content("#{@job_12.title} was successfully deleted!")
  end
end
