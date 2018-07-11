require 'rails_helper'

describe "A User" do
  before :each do
    @category_1 = Category.create(title: "Finance")
    @category_2 = Category.create(title: "Definitely Not Finance")
    @category_3 = Category.create(title: "Probably Finance")
  end
  scenario "can edit a category" do
    visit categories_path

    within(".category_#{@category_3.id}") do
      click_link "Edit"
    end

    expect(current_path).to eq("/categories/#{@category_3.id}/edit")

    fill_in "category[title]", with: "Marketing"

    click_button "Update"

    expect(page).to have_content(Category.find(@category_3.id).title)
  end
  scenario "can't successfully edit a ctaegory with blank fields'" do
    visit categories_path

    within(".category_#{@category_3.id}") do
      click_link "Edit"
    end
    
    expect(current_path).to eq(edit_category_path(@category_3))

    fill_in "category[title]", with: ""

    click_button "Update"

    expect(page).to have_content('Category not updated.')
  end
end
