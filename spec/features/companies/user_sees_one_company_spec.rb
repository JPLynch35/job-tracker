require 'rails_helper'

describe "User sees one company" do
  before :each do
    @category = Category.create(title: 'Finance')
    @company_1 = Company.create(name: "ESPN")
    @company_2 = Company.create(name: "Disney")
    @company_1.jobs.create(title: "Developer", level_of_interest: 90, city: "Denver", category_id: @category.id)
    @contact_1 = @company_1.contacts.create(name: "Chris Camp", role: "Manager", email: "chris@espn.com")
    @contact_2 = @company_1.contacts.create(name: "Allen Bootleg", role: "Minion", email: "allen@espn.com")
  end
  scenario "a user sees a company" do
    visit company_path(@company_2)

    expect(current_path).to eq("/companies/#{@company_2.id}")
    expect(page).to have_content("Disney")
  end
  scenario "a user sees a company's jobs" do
    visit company_jobs_path(@company_1)

    expect(current_path).to eq("/companies/#{@company_1.id}/jobs")
    expect(page).to have_content("ESPN")
    expect(page).to have_content("Developer")
  end
  scenario "a user sees company's contacts" do

    visit company_path(@company_1)

    expect(current_path).to eq("/companies/#{@company_1.id}")
    expect(page).to have_content(@contact_1.name)
    expect(page).to have_content(@contact_2.email)
  end
end
