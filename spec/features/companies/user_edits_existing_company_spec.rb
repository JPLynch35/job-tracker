require 'rails_helper'

describe "User edits an existing company" do
  before :each do
    @company_1 = Company.create(name: "ESPN")
    @company_2 = Company.create(name: "Disney")
    @company_1.jobs.create(title: "Developer", level_of_interest: 3, city: "Denver")
  end
  scenario "a user can edit a company" do
    visit companies_path

    within ".company_#{@company_1.id}" do
      click_link "Edit"
    end

    expect(current_path).to eq(edit_company_path(@company_1))

    visit edit_company_path(@company_1)
    fill_in "company[name]", with: "EA Sports"
    click_button "Update"
    expect(current_path).to eq("/companies/#{Company.first.id}")
    expect(page).to have_content("EA Sports")
    expect(page).to_not have_content("ESPN")
  end
  scenario "a user can't update a company without required fields" do
    visit companies_path

    within ".company_#{@company_1.id}" do
      click_link "Edit"
    end

    visit edit_company_path(@company_1)

    fill_in "company[name]", with: ""
    click_button "Update"

    expect(page).to have_content("Edit here!")
  end
end
