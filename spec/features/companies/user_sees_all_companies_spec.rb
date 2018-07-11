require 'rails_helper'

describe "User sees all companies" do
  before :each do
    @company_1 = Company.create(name: "ESPN")
    @company_2 = Company.create(name: "Disney")
    @company_1.jobs.create(title: "Developer", level_of_interest: 4, city: "Denver")
  end
  scenario "a user sees all the companies" do
    visit companies_path

    expect(page).to have_content("ESPN")
  end

end
