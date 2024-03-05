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

Badge.create([
  # Registration Badges #
  { name: 'First 100', description: 'Awarded to the first 100 registered users.', image_url: 'hundred.png' },
  { name: 'First 1K', description: 'Awarded to the first 1,000 registered users.', image_url: 'thousand.png'},
  # Post Creation Badges #
  { name: 'Youngling', description: 'Awarded for making 1-100 posts.', image_url: 'youngling.png' },
  { name: 'Padawan', description: 'Awarded for making 101~200 posts.', image_url: 'yadoling.png'},
  { name: 'Jedi Knight', description: 'Awarded for making 201~300 posts.', image_url: 'knight.png'},
  { name: 'Jedi Master', description: 'Awarded for making 301~400 posts.', image_url: 'master.png'},
  { name: 'Jedi Council Member', description: 'Awarded for making 401~500 posts.', image_url: 'council.png'},
  { name: 'Master of Order', description: 'Awarded for making 501~1,000 posts.', image_url: 'order.png'},
  { name: 'Grand Master', description: 'Awarded for making 1K+ posts.', image_url: 'grandmaster.png'},
])


categories.each do |category_name|
  Category.find_or_create_by(name: category_name)


end
