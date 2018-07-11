require 'rails_helper'

describe "A User" do
  before :each do
    @category_1 = Category.create(title: "Finance")
    @category_2 = Category.create(title: "Definitely Not Finance")
    @company_1 = Company.create(name: "ESPN")
    @job_11 = @company_1.jobs.create(title: "Developer", level_of_interest: 2, city: "Denver", category_id: @category_1.id)
    @job_12 = @company_1.jobs.create(title: "QA Analyst", level_of_interest: 3, city: "New York City", category_id: @category_2.id)
    @company_2 = Company.create(name: "Apple")
    @job_21 = @company_2.jobs.create(title: "Manager", level_of_interest: 5, city: "Denver", category_id: @category_1.id)
  end
  scenario "sees all categories" do
    visit categories_path

    click_link "2 jobs"

    expect(page).to have_content(@job_11.title)
    expect(page).to have_content(@job_21.title)
    expect(page).to_not have_content(@job_12.title)
  end
end
