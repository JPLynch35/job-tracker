describe 'a visitor' do
  describe 'visiting the job show page' do
    it 'should be able to see comments' do
      @category = Category.create(title: 'Finance')
      @company = Company.create(name: "ESPN")
      @job = @company.jobs.create(title: "Developer", level_of_interest: 4, city: "Denver", category_id: @category.id)
      @job.comments.create(content: "This is a great job, I really love finance.")

      visit job_path(@job)

      expect(current_path).to eq(job_path(@job))
      expect(page).to have_content("This is a great job, I really love finance.")
    end
    it 'should be able to fill in the comments form and save a comment' do
      @category = Category.create(title: 'Finance')
      @company = Company.create(name: "ESPN")
      @job = @company.jobs.create(title: "Developer", level_of_interest: 4, city: "Denver", category_id: @category.id)

      visit job_path(@job)
      fill_in "comment[content]", with: "I made a comment right on the page!"
      click_button "Create Comment"

      expect(current_path).to eq(job_path(@job))
      expect(page).to have_content("I made a comment right on the page!")
    end
    it 'should show the newest comments on top' do
      @category = Category.create(title: 'Finance')
      @company = Company.create(name: "ESPN")
      @job = @company.jobs.create(title: "Developer", level_of_interest: 3, city: "Denver", category_id: @category.id)

      visit job_path(@job)
      fill_in "comment[content]", with: "This is the first comment"
      click_button "Create Comment"
      fill_in "comment[content]", with: "This is the second comment"
      click_button "Create Comment"
      
      expect("This is the second comment").to appear_before("This is the first comment")
    end
  end
end
