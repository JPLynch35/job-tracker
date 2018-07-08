require 'rails_helper'

describe 'a user visits /dashboard' do
  before :each do
    @category = Category.create(title: 'Finance')
    @company_1 = Company.create(name: "ESPN")
    @company_2 = Company.create(name: "Apple")
    @company_3 = Company.create(name: "IBM")
    @job_1 = @company_1.jobs.create(title: "Developer", level_of_interest: 2, city: "Denver", category_id: @category.id)
    @job_2 = @company_2.jobs.create(title: "QA Analyst", level_of_interest: 2, city: "New York City", category_id: @category.id)
    @job_3 = @company_1.jobs.create(title: "Manager1", level_of_interest: 4, city: "Denver", category_id: @category.id)
    @job_4 = @company_2.jobs.create(title: "Manager2", level_of_interest: 4, city: "Denver", category_id: @category.id)
    @job_5 = @company_3.jobs.create(title: "Manager3", level_of_interest: 4, city: "Denver", category_id: @category.id)
    @job_6 = @company_2.jobs.create(title: "Manager4", level_of_interest: 4, city: "Denver", category_id: @category.id)
    @job_7 = @company_3.jobs.create(title: "Manager5", level_of_interest: 5, city: "Denver", category_id: @category.id)
    @job_8 = @company_3.jobs.create(title: "Manager6", level_of_interest: 5, city: "Denver", category_id: @category.id)
    @job_9 = @company_3.jobs.create(title: "Manager7", level_of_interest: 5, city: "Denver", category_id: @category.id)
  end
  scenario 'should see a job counts grouped by level of interest' do
    visit dashboard_index_path

    expect(page).to have_content("(3 jobs)")
    expect(page).to have_content("(4 jobs)")
    expect(page).to have_content("(2 jobs)")
  end
  scenario 'should see top companies level of interest along with average interest per company' do
    visit dashboard_index_path

    expect(page).to have_content("IBM (4.8 stars)")
    expect(page).to have_content("Apple (3.3 stars)")
    expect(page).to have_content("ESPN (3.0 stars)")
  end
end
