require 'rails_helper'

describe "A User" do
  before :each do
    @category_1 = Category.create(title: "Finance")
    @category_2 = Category.create(title: "Definitely Not Finance")
    @category_3 = Category.create(title: "Probably Finance")
  end
  scenario "sees all categories" do
    visit categories_path

    expect(page).to have_content(@category_1.title)
    expect(page).to have_content(@category_2.title)
    expect(page).to have_content(@category_3.title)

    expect(Category.count).to eq(3)
  end
end
