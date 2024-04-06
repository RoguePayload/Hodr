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
  { name: 'First 100', description: 'Awarded to the first 100 registered users.', image_url: 'hodr_hundred.png' },
  { name: 'First 1K', description: 'Awarded to the first 1,000 registered users.', image_url: 'thousand.png'},
  # Post Creation Badges #
  { name: 'FreshAlien', description: 'Awarded for making 1-100 posts.', image_url: 'hodr_1-100.png' },
  { name: 'TravelingAlien', description: 'Awarded for making 101~200 posts.', image_url: 'hodr_101-200.png'},
  { name: 'ExperiencedAlien', description: 'Awarded for making 201~300 posts.', image_url: 'hodr_201-300.png'},
  { name: 'GalaxyTraveler', description: 'Awarded for making 301~400 posts.', image_url: 'hodr_301-400.png'},
  { name: 'CosmicExplorer', description: 'Awarded for making 401~500 posts.', image_url: 'hodr_401-500.png'},
  { name: 'CosmicMapMaker', description: 'Awarded for making 501~1,000 posts.', image_url: 'hodr_501-1k.png'},
  { name: 'GrandCosmicExplorer', description: 'Awarded for making 1K+ posts.', image_url: 'hodr_1k.png'},
])


categories.each do |category_name|
  Category.find_or_create_by(name: category_name)


end
