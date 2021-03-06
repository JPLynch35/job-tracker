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
  scenario "a user can click on the link to see other jobs with the same category" do
    visit job_path(@job_21)

    click_on "See Other #{@job_21.category.title} Positions"

    expect(page).to have_content(@job_11.title)
    expect(page).to have_content(@job_12.title)
  end
  scenario 'should be able to see comments' do
    @job_11.comments.create(content: "This is a great job, I really love finance.")
    @job_11.comments.create(content: "This is a not a great job, I really hate finance.")

    visit job_path(@job_11)

    expect(current_path).to eq(job_path(@job_11))
    expect(page).to have_content("This is a great job, I really love finance.")
  end
  scenario 'should be able to fill in the comments form and save a comment' do
    @job_11.comments.create(content: "This is a great job, I really love finance.")
    @job_11.comments.create(content: "This is a not a great job, I really hate finance.")

    visit job_path(@job_11)
    fill_in "comment[content]", with: "I made a comment right on the page!"
    click_button "Create Comment"

    expect(current_path).to eq(job_path(@job_11))
    expect(page).to have_content("I made a comment right on the page!")
  end
  scenario 'should show the newest comments on top' do
    @job_11.comments.create(content: "This is a great job, I really love finance.")
    @job_11.comments.create(content: "This is a not a great job, I really hate finance.")

    visit job_path(@job_11)
    fill_in "comment[content]", with: "This is the first comment"
    click_button "Create Comment"
    fill_in "comment[content]", with: "This is the second comment"
    click_button "Create Comment"
    
    expect("This is the second comment").to appear_before("This is the first comment")
  end
  scenario 'can delete a comment' do
    @comment_1 = @job_11.comments.create(content: "This is a great job, I really love finance.")
    @comment_2 = @job_11.comments.create(content: "This is a not a great job, I really hate finance.")

    visit job_path(@job_11)

    within("#comment_#{@comment_1.id}") do
      click_on('Delete')
    end

    expect(page).to_not have_content(@comment_1.content)
    expect(page).to have_content(@comment_2.content)
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
    click_link "See Jobs at #{@company_1.name}"
    click_link "#{@job_11.title}"

    expect(current_path).to eq(company_job_path(@company_1, @job_11))
    expect(page).to have_content("ESPN")
    expect(page).to have_content("Developer")
  end
  scenario "a user deleting a job from a company/job url will be directed back to the company jobs page" do
    visit company_job_path(@company_1, @job_11)
    click_link "Delete"

    expect(current_path).to eq(company_jobs_path(@company_1))
    expect(page).to have_content("#{@job_11.title} was successfully deleted!")
  end
end
