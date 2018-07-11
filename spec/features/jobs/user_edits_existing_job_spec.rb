require 'rails_helper'

describe "User edits an existing job" do
  before :each do
    @category = Category.create(title: 'Finance')
    @company_1 = Company.create(name: "ESPN")
    @job_11 = @company_1.jobs.create(title: "Developer", level_of_interest: 5, city: "Denver", category_id: @category.id)
    @job_12 = @company_1.jobs.create(title: "QA Analyst", level_of_interest: 5, city: "New York City", category_id: @category.id)
    @company_2 = Company.create(name: "Apple")
    @job_21 = @company_2.jobs.create(title: "Manager", level_of_interest: 3, city: "Denver", category_id: @category.id)
  end
  scenario "a user can edit a job" do
    visit job_path(@job_11)

    click_link 'Edit'

    expect(current_path).to eq("/jobs/#{@job_11.id}/edit")
    
    new_title = "Newer Title!"
    fill_in "job[title]", with: new_title
    click_button "Update"

    expect(current_path).to eq("/jobs/#{@job_11.id}")
    expect(page).to have_content("#{new_title}")
  end
  scenario "a user can edit a job for a specific company" do
    visit company_job_path(@company_1, @job_11)

    click_link 'Edit'

    expect(current_path).to eq("/companies/#{@company_1.id}/jobs/#{@job_11.id}/edit")
    
    new_title = "Newer Title!"
    fill_in "job[title]", with: new_title
    click_button "Update"

    expect(current_path).to eq("/companies/#{@company_1.id}/jobs/#{@job_11.id}")
    expect(page).to have_content("#{new_title} at #{@company_1.name}")
  end
  scenario "a user can't edit a job without all required fields" do
    visit company_job_path(@company_1, @job_11)

    click_link 'Edit'

    new_title = ""
    fill_in "job[title]", with: new_title
    click_button "Update"

    expect(page).to have_content("Edit here!")
  end
end
