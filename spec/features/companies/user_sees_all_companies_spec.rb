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
  scenario "a user can delete a company" do
    visit companies_path

    within ".company_#{@company_1.id}" do
      click_link "Delete"
    end

    expect(current_path).to eq(companies_path)
    expect(page).to have_content("ESPN was successfully deleted!")
    expect(page).to have_content("Disney")
  end
  scenario "a user can edit a company" do
    visit companies_path

    within ".company_#{@company_1.id}" do
      click_link "Edit"
    end

    expect(current_path).to eq(edit_company_path(@company_1))
    expect(page).to have_content("Edit ESPN here!")
  end
  scenario "a user can click add company and get to company/new" do
    visit companies_path

    click_link "Add Company"

    expect(current_path).to eq(new_company_path)
  end
  scenario "a user can click a company name and get to company/:id" do
    visit companies_path

    click_link "#{@company_1.name}"

    expect(current_path).to eq(company_path(@company_1))
  end
end
