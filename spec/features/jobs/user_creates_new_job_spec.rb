require 'rails_helper'

describe "User creates a new job" do
  before :each do
    @category = Category.create(title: 'Finance')
    @company = Company.create(name: "ESPN")
  end
  scenario "a user can create a new job" do
    visit jobs_path
    click_link "Add Job"
    expect(current_path).to eq("/jobs/new")

    fill_in "job[title]", with: "Developer"
    fill_in "job[description]", with: "So fun!"
    select "4", from: "job[level_of_interest]"
    select 'ESPN', from: "Company"
    select "Finance", from: "Category"
    fill_in "job[city]", with: "Denver"

    click_button "Create"

    expect(current_path).to eq("/jobs/#{Job.last.id}")
    expect(page).to have_content("ESPN")
    expect(page).to have_content("Developer")
    expect(page).to have_content("Denver")
  end
  scenario "a user can create a new job from a company" do
    visit company_jobs_path(@company)
    click_link "Add Job"
    expect(current_path).to eq("/companies/#{@company.id}/jobs/new")

    fill_in "job[title]", with: "Developer"
    fill_in "job[description]", with: "So fun!"
    select "4", from: "job[level_of_interest]"
    fill_in "job[city]", with: "Denver"
    select "Finance", from: "Category"

    click_button "Create"

    expect(current_path).to eq("/companies/#{@company.id}/jobs/#{Job.last.id}")
    expect(page).to have_content("ESPN")
    expect(page).to have_content("Developer")
    expect(page).to have_content("Denver")
  end
  scenario "a user can't create a new job without the required fields" do
    visit company_jobs_path(@company)
    click_link "Add Job"

    fill_in "job[description]", with: "So fun!"
    select "4", from: "job[level_of_interest]"
    fill_in "job[city]", with: "Denver"

    click_button "Create"

    expect(page).to have_content("Create a new job here!")
  end
  scenario "a user is directed to /categories/new from /jobs/new" do
    visit new_job_path
    click_link "Add New Category"

    expect(current_path).to eq("/categories/new")
  end
end
