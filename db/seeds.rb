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
  { name: 'First 100 Registered Users', description: 'Awarded to the first 100 registered users.', image_url: 'first_100_users.png' },
  { name: 'First 1,000 Registered Users', description: 'Awarded to the first 1,000 registered users.', image_url: 'first_1000_users.png' },

  # Micropost Creation Badges #
  { name: 'Content Maker', description: 'Awarded for making 1-100 posts.', image_url: 'mypage_1-100.png' },
  { name: 'MyPage Creator', description: 'Awarded for making 101~200 posts.', image_url: 'mypage_101-200.png'},
  { name: 'MyPage Influencer', description: 'Awarded for making 201~300 posts.', image_url: 'mypage_201-300.png'},
  { name: 'MyPage Post Creator', description: 'Awarded for making 301~400 posts.', image_url: 'mypage_301-400.png'},
  { name: 'MyPage Heavy Influencer', description: 'Awarded for making 401~500 posts.', image_url: 'mypage_401-500.png'},
  { name: 'MyPage Post Master', description: 'Awarded for making 501~1,000 posts.', image_url: 'mypage_501-1k.png'},
  { name: 'MyPage Content Master', description: 'Awarded for making 1K+ posts.', image_url: 'mypage_1k.png'},

  # Other Badges #
  { name: 'Premium Badge', description: 'Awarded to premium users.', image_url: 'premium_badge.png' },
  { name: 'Admin Badge', description: 'Awarded to administrators.', image_url: 'admin_badge.png' }
])



categories.each do |category_name|
  Category.find_or_create_by(name: category_name)


end
