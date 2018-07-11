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
  scenario "fills in contact form and sees contacts" do
    visit company_path(@company_1)

    contact_name = "Bart Simpson"
    contact_role = "Cartoon"
    contact_email = "bart@simpson.com"

    fill_in :contact_name, with: contact_name
    fill_in :contact_role, with: contact_role
    fill_in :contact_email, with: contact_email

    click_on "Create Contact"

    expect(current_path).to eq(company_path(@company_1))
    expect(page).to have_content(contact_name)
    expect(page).to have_content(contact_role)
    expect(page).to have_content(contact_email)
  end
  scenario "fills in incomplete contact form and doesn't see contact" do
    visit company_path(@company_1)

    contact_name = nil
    contact_role = "Cartoon"
    contact_email = "bart@simpson.com"

    fill_in :contact_name, with: contact_name
    fill_in :contact_role, with: contact_role
    fill_in :contact_email, with: contact_email

    click_on "Create Contact"

    expect(current_path).to eq(company_path(@company_1))
    expect(page).to_not have_content(contact_role)
    expect(page).to_not have_content(contact_email)
  end
  scenario "clicks Edit from company/:id and gets to company/:id/edit" do
    visit company_path(@company_1)

    click_on "Edit"

    expect(current_path).to eq(edit_company_path(@company_1))
  end
  scenario "clicks Delete from company/:id and gets to /companies" do
    visit company_path(@company_1)

    within('#company-buttons') do
      click_on("Delete")
    end

    expect(current_path).to eq(companies_path)
    expect(page).to have_content("#{@company_1.name} was successfully deleted!")
  end
  scenario "can delete individual contacts" do
    visit company_path(@company_1)

    expect(page).to have_content(@contact_1.name)

    within("#contact_#{@contact_1.id}") do
      click_on("Delete")
    end

    expect(page).to have_content("#{@contact_1.name} was successfully deleted!")
  end
end
