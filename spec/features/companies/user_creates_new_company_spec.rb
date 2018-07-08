require 'rails_helper'

describe "User creates a new company" do
  before :each do
    @company_1 = Company.create(name: "ESPN")
    @company_2 = Company.create(name: "Disney")
    @company_1.jobs.create(title: "Developer", level_of_interest: 90, city: "Denver")
  end
  scenario "a user can create a new company" do
    visit companies_path
    click_link "Add Company"

    expect(current_path).to eq(new_company_path)

    fill_in "company[name]", with: "The Ocho"
    click_button "Create"

    expect(current_path).to eq("/companies/#{Company.last.id}")
    expect(page).to have_content("The Ocho")
    expect(Company.count).to eq(3)
  end
  scenario "a user can't create a new company without required fields" do
    visit companies_path
    click_link "Add Company"

    expect(current_path).to eq(new_company_path)

    click_button "Create"

    expect(page).to have_content("Create a new company here!")
  end
end
