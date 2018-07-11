Company.destroy_all
Job.destroy_all

COMPANIES = ["ESPN", "Aetna", "United Airlines", "Denver Public Schools", "Shopify", "Starbucks", "Pivotal Labs", "Captain U"]
JOBS = ["Engineering", "Development", "Dev Ops", "Quality Assurance", "Teacher", "Product Manager", "Consultant", "Community Manager"]
CITIES = ["Seattle", "Denver", "Portland", "Indianapolis", "Madison", "Orlando", "San Diego", "Austin", "Las Vegas", "Little Rock", "Boise", "Eugene", "Oakland"]
CATEGORIES = ["Finance", "Development", "Teacher", "Consultant"]
COMPANIES.each do |name|
  category = Category.create(title: CATEGORIES.sample)
  company = Company.create(name: name)
  puts "Created #{company.name}"
  10.times do |num|
    company.jobs.create(title: JOBS.sample, description: "What a great position!", level_of_interest: rand(5), city: CITIES.sample, category_id: category.id)
    puts "  Created #{company.jobs[num].title}"
  end
end
