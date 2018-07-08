require 'rails_helper'

describe "User creates a new category" do
  scenario "a user can create a new category" do
    category = Category.create(title: "Finance")
    visit categories_path
    click_link "Add New Category"

    expect(current_path).to eq(new_category_path)

    fill_in "category[title]", with: "Marketing"
    click_button "Create"

    expect(current_path).to eq("/categories/#{Category.last.id}/jobs")
    expect(page).to have_content("Finance")
    expect(Category.count).to eq(2)
  end
  scenario "a user can't create a new category without required fields" do
    category = Category.create(title: "Finance")
    visit categories_path
    click_link "Add New Category"

    expect(current_path).to eq(new_category_path)

    click_button "Create"

    expect(page).to have_content("Add Category")
  end
end
