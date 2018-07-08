require 'rails_helper'

describe "User deletes existing company" do
  before :each do
    @company_1 = Company.create(name: "ESPN")
    @company_2 = Company.create(name: "Disney")
    @company_1.jobs.create(title: "Developer", level_of_interest: 90, city: "Denver")
  end
  scenario "a user can delete a company" do
    visit companies_path

    within(".company_#{@company_1.id}") do
      click_link "Delete"
    end

    expect(page).to have_content("ESPN was successfully deleted!")
  end
end
