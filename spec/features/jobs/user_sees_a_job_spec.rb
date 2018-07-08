require 'rails_helper'

describe "User sees a specific job" do
  scenario "a user sees a job for an unspecific company" do
    company = Company.create(name: "ESPN")
    job = company.jobs.create(title: "Developer", level_of_interest: 70, city: "Denver")

    visit jobs_path
    click_link "#{job.title}"
    expect(current_path).to eq("/jobs/#{job.id}")

    expect(page).to have_content("ESPN")
    expect(page).to have_content("Developer")
    expect(page).to have_content("70")
  end
  scenario "a user sees a job for a specific company" do
    company = Company.create(name: "ESPN")
    job = company.jobs.create(title: "Developer", level_of_interest: 70, city: "Denver")

    visit company_path(company)
    click_link 'Jobs'
    click_link "#{job.title}"
    expect(current_path).to eq("/companies/#{company.id}/jobs/#{job.id}")

    expect(page).to have_content("ESPN")
    expect(page).to have_content("Developer")
    expect(page).to have_content("70")
  end
end
