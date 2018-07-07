require 'rails_helper'

describe "User edits an existing job" do
  scenario "a user can edit a job" do
    company = Company.create(name: "ESPN")
    job = company.jobs.create(title: "Developer", level_of_interest: 70, city: "Denver")

    visit company_job_path(company, job)

    click_link 'Edit'

    expect(current_path).to eq("/companies/#{company.id}/jobs/#{job.id}/edit")
    
    new_title = "Newer Title!"
    fill_in "job[title]", with: new_title
    click_button "Update"

    expect(current_path).to eq("/companies/#{company.id}/jobs/#{job.id}")
    expect(page).to have_content("Title: #{new_title}")
  end
end
