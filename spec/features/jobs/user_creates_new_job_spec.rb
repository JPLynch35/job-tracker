require 'rails_helper'

describe "User creates a new job" do
  scenario "a user can create a new job" do
    company = Company.create(name: "ESPN")

    visit company_jobs_path(company)
    click_link "Add Job"
    expect(current_path).to eq("/companies/#{company.id}/jobs/new")

    fill_in "job[title]", with: "Developer"
    fill_in "job[description]", with: "So fun!"
    fill_in "job[level_of_interest]", with: 80
    fill_in "job[city]", with: "Denver"

    click_button "Create"

    expect(current_path).to eq("/companies/#{company.id}/jobs/#{Job.last.id}")
    expect(page).to have_content("ESPN")
    expect(page).to have_content("Developer")
    expect(page).to have_content("80")
    expect(page).to have_content("Denver")
  end
  scenario "a user can't create a new job without the required fields" do
    company = Company.create(name: "ESPN")

    visit company_jobs_path(company)
    click_link "Add Job"

    fill_in "job[description]", with: "So fun!"
    fill_in "job[level_of_interest]", with: 80
    fill_in "job[city]", with: "Denver"

    click_button "Create"

    expect(page).to have_content("Create a new job at #{company.name} here!")
  end
end
