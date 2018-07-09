describe 'a visitor' do
  describe 'visiting the job show page' do
    it 'should be able to fill in the comments form and save a comment' do
      @category = Category.create(title: 'Finance')
      @company = Company.create(name: "ESPN")
      @job = @company.jobs.create(title: "Developer", level_of_interest: 70, city: "Denver", category_id: @category.id)

      visit job_path(@job)

      fill_in "comment[content]", with: "This is a great job, I really love finance."
      click_link "Create Comment"

      expect(current_path).to eq(job_path(@job))
      expect(page).to have_content("This is a great job, I really love finance.")
    end
  end
end
