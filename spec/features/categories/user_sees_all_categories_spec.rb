require 'rails_helper'

describe "A User" do
  before :each do
    @category_1 = Category.create(title: "Finance")
    @category_2 = Category.create(title: "Definitely Not Finance")
    @category_3 = Category.create(title: "Probably Finance")
    @company_1 = Company.create(name: "ESPN")
    @job_11 = @company_1.jobs.create(title: "Developer", level_of_interest: 2, city: "Denver", category_id: @category_1.id)
    @job_12 = @company_1.jobs.create(title: "QA Analyst", level_of_interest: 3, city: "New York City", category_id: @category_1.id)
    @company_2 = Company.create(name: "Apple")
    @job_21 = @company_2.jobs.create(title: "Manager", level_of_interest: 1, city: "Denver", category_id: @category_2.id)
  end
  scenario "sees all categories" do
    visit categories_path

    expect(page).to have_content(@category_1.title)
    expect(page).to have_content(@category_2.title)
    expect(page).to have_content(@category_3.title)

    expect(Category.count).to eq(3)
  end
  scenario "can delete category from categories page" do
    visit categories_path

    expect(page).to have_content(@category_1.title)

    within(".category_#{@category_1.id}") do
      click_on 'Delete'
    end

    expect(page).to have_content("#{@category_1.title} was successfully deleted!")
  end
  scenario "clicks on the number of jobs next to category and sees all jobs within that category" do
    visit categories_path

    click_on('2 jobs')
    expect(page).to have_content(@job_11.title)
    expect(page).to have_content(@job_12.title)
  end
end
