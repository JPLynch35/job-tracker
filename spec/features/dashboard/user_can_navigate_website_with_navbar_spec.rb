require 'rails_helper'

describe 'a user visits /dashboard' do
  before :each do
    @category = Category.create(title: 'Finance')
    @company_1 = Company.create(name: "ESPN")
    @job_1 = @company_1.jobs.create(title: "Developer", level_of_interest: 2, city: "Denver", category_id: @category.id)
  end
  describe 'can navigate the website' do
    scenario 'utilizing the navbar' do
      visit dashboard_index_path

      within '.nav' do
        click_on 'Companies'
      end

      expect(current_path).to eq(companies_path)

      within '.nav' do
        click_on 'Jobs'
      end

      expect(current_path).to eq(jobs_path)

      within '.nav' do
        click_on 'Categories'
      end

      expect(current_path).to eq(categories_path)

      within '.nav' do
        click_on 'Dashboard'
      end

      expect(current_path).to eq(dashboard_index_path)

      within 'footer' do
        click_on '<< Go Back'
      end

      expect(current_path).to eq(categories_path)
    end
  end
end
