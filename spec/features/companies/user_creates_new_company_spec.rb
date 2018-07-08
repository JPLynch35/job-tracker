require 'rails_helper'

describe "User creates a new company" do
  scenario "a user can create a new company" do
    company = Company.create(name: "The Ocho")
    visit companies_path
    click_link "Add Company"

    expect(current_path).to eq(new_company_path)

    fill_in "company[name]", with: "ESPN"
    click_button "Create"

    expect(current_path).to eq("/companies/#{Company.last.id}")
    expect(page).to have_content("ESPN")
    expect(Company.count).to eq(2)
  end
  scenario "a user can't create a new company without required fields" do
    company = Company.create(name: "The Ocho")
    visit companies_path
    click_link "Add Company"

    expect(current_path).to eq(new_company_path)

    click_button "Create"

    expect(page).to have_content("Create a new company here!")
  end
end
