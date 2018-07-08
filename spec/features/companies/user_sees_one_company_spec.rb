require 'rails_helper'

describe "User sees one company" do
  before :each do
    @category = Category.create(title: 'Finance')
    @company_1 = Company.create(name: "ESPN")
    @company_2 = Company.create(name: "Disney")
    @company_1.jobs.create(title: "Developer", level_of_interest: 90, city: "Denver", category_id: @category.id)
  end
  scenario "a user sees a company" do
    visit company_jobs_path(@company_1)

    expect(current_path).to eq("/companies/#{@company_1.id}/jobs")
    expect(page).to have_content("ESPN")
    expect(page).to have_content("Developer")
  end
end
