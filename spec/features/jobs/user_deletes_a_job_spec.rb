require 'rails_helper'

describe "User deletes existing job" do
  scenario "a user can delete a job" do
    company = Company.create(name: "ESPN")
    job_1 = company.jobs.create(title: "Developer", level_of_interest: 70, city: "Denver")
    job_2 = company.jobs.create(title: "Jr. Developer", level_of_interest: 50, city: "Denver")

    visit job_path(job_2)

    click_link "Delete"

    expect(current_path).to eq ("/jobs")
    expect(page).to have_content("#{job_1.title}")
    expect(page).to have_content("#{job_2.title} was successfully deleted!")
  end
  scenario "a user can delete a job for a specific company" do
    company = Company.create(name: "ESPN")
    job_1 = company.jobs.create(title: "Developer", level_of_interest: 70, city: "Denver")
    job_2 = company.jobs.create(title: "Jr. Developer", level_of_interest: 50, city: "Denver")

    visit company_job_path(company, job_2)

    click_link "Delete"

    expect(current_path).to eq ("/companies/#{company.id}/jobs")
    expect(page).to have_content("#{job_1.title}")
    expect(page).to have_content("#{job_2.title} was successfully deleted!")
  end
end
