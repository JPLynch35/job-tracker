require 'rails_helper'

describe "User sees all jobs" do
  before :each do
    @category = Category.create(title: 'Finance')
    @company_1 = Company.create(name: "ESPN")
    @job_11 = @company_1.jobs.create(title: "Developer", level_of_interest: 2, city: "Denver", category_id: @category.id)
    @job_12 = @company_1.jobs.create(title: "QA Analyst", level_of_interest: 1, city: "New York City", category_id: @category.id)
    @company_2 = Company.create(name: "Apple")
    @job_21 = @company_2.jobs.create(title: "Manager", level_of_interest: 5, city: "Denver", category_id: @category.id)
  end
  scenario "a user sees all jobs" do
    visit jobs_path

    expect(page).to have_content("Developer")
    expect(page).to have_content("QA Analyst")
    expect(page).to have_content("Manager")
    expect(page).to have_content("#{@job_11.title} at #{@company_1.name} - #{@job_11.city}")
  end
  scenario "a user clicks on sort by location and sees the sort" do
    visit jobs_path

    click_on "Sort all jobs by location"

    expect(@job_11.title).to appear_before(@job_21.title)
    expect(@job_21.title).to appear_before(@job_12.title)
  end
  scenario "a user clicks on sort by interest and sees the sort" do
    visit jobs_path

    click_on "Sort all jobs by interest"

    expect(@job_12.title).to appear_before(@job_11.title)
    expect(@job_11.title).to appear_before(@job_21.title)
  end
  scenario "a user clicks on a job title and sees the job show page" do
    visit jobs_path

    click_on @job_11.title

    expect(current_path).to eq(job_path(@job_11))
  end
  scenario "a user can delete a job" do
    visit jobs_path

    within("#job_#{@job_11.id}") do
      click_on 'Delete'
    end

    expect(page).to_not have_content("#{@job_11.title} at #{@job_11.company.name}")
  end
  scenario "a user can edit a job" do
    visit jobs_path

    within("#job_#{@job_11.id}") do
      click_on 'Edit'
    end

    expect(current_path).to eq(edit_job_path(@job_11))
  end
  scenario "a user sees all the jobs for a specific company" do
    visit company_jobs_path(@company_1)

    expect(page).to have_content("ESPN")
    expect(page).to have_content("Developer")
    expect(page).to have_content("QA Analyst")
  end
end
