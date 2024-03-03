categories = [
  "General Discussion",
  "Announcements",
  "Technology",
  "Gaming",
  "Entertainment",
  "Music",
  "Sports",
  "Lifestyle",
  "Food and Cooking",
  "Travel",
  "Health and Fitness",
  "Fashion and Beauty",
  "Hobbies and Crafts",
  "Science and Nature",
  "Education and Learning",
  "Business and Finance",
  "Art and Photography",
  "Literature and Writing",
  "Politics and Social Issues",
  "DIY and Home Improvement"
]

categories.each do |category_name|
  Category.find_or_create_by(name: category_name)
end
