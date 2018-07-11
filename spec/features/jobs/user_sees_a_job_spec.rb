require 'rails_helper'

describe "When a user visits /jobs/:id" do
  before :each do
    @category = Category.create(title: 'Finance')
    @company_1 = Company.create(name: "ESPN")
    @job_11 = @company_1.jobs.create(title: "Developer", level_of_interest: 2, city: "Denver", category_id: @category.id)
    @job_12 = @company_1.jobs.create(title: "QA Analyst", level_of_interest: 3, city: "New York City", category_id: @category.id)
    @company_2 = Company.create(name: "Apple")
    @job_21 = @company_2.jobs.create(title: "Manager", level_of_interest: 1, city: "Denver", category_id: @category.id)
  end
  scenario "a user sees a job for an unspecific company" do
    visit jobs_path
    click_link "#{@job_11.title}"
    expect(current_path).to eq("/jobs/#{@job_11.id}")

    expect(page).to have_content("ESPN")
    expect(page).to have_content("Developer")
  end
  scenario "a user can go to the edit page" do
    visit job_path(@job_11)

    click_on "Edit"

    expect(current_path).to eq(edit_job_path(@job_11))
  end
  scenario "a user can delete the job" do
    visit job_path(@job_11)

    click_on "Delete"

    expect(current_path).to eq(jobs_path)
    expect(page).to_not have_content("#{@job_11.title} at #{@job_11.company} - #{@job_11.city}")
  end
  scenario "a user can click on the company name to see the company show page" do
    visit job_path(@job_21)

    click_on "#{@job_21.company.name}"

    expect(current_path).to eq(company_path(@job_21.company))
  end
  scenario "a user can click on the link to see other same category jobs" do
    visit job_path(@job_21)

    click_on "#{@job_21.company.name}"

    expect(current_path).to eq(company_path(@job_21.company))
  end
end
describe 'When a user visits /companies/:id/job:id' do
  before :each do
    @category = Category.create(title: 'Finance')
    @company_1 = Company.create(name: "ESPN")
    @job_11 = @company_1.jobs.create(title: "Developer", level_of_interest: 2, city: "Denver", category_id: @category.id)
    @job_12 = @company_1.jobs.create(title: "QA Analyst", level_of_interest: 3, city: "New York City", category_id: @category.id)
    @company_2 = Company.create(name: "Apple")
    @job_21 = @company_2.jobs.create(title: "Manager", level_of_interest: 1, city: "Denver", category_id: @category.id)
  end
  scenario "a user sees a job for a specific company" do
    visit company_path(@company_1)
    click_link 'Jobs'
    click_link "#{@job_11.title}"
    expect(current_path).to eq("/jobs/#{@job_11.id}")

    expect(page).to have_content("ESPN")
    expect(page).to have_content("Developer")
  end
end
