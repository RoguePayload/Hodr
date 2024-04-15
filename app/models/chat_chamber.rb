class ChatChamber < ApplicationRecord

  CATEGORIES = [
    'Technology', 'Computer Building', 'Website Programming', 'Mobile Development',
    'Server Hosting', 'Hacking Services', 'AI & Machine Learning', 'Data Science',
    'Video Games', 'Console Gaming', 'PC Gaming', 'Mobile Gaming', 'Esports',
    'Video Streaming', 'Content Creation', 'Video Editing', 'Film Making',
    'Sports', 'Football', 'Softball', 'Soccer', 'Baseball', 'Basketball', 'Tennis',
    'Hockey', 'Cricket', 'Rugby', 'Athletics', 'Cycling', 'Extreme Sports',
    'Home & Garden', 'DIY Projects', 'Gardening', 'Home Renovation', 'Interior Design',
    'Painting', 'Arts & Crafts', 'Sculpture', 'Digital Art', 'Photography',
    'Education', 'Online Learning', 'Professional Development', 'Languages',
    'Music', 'Instruments', 'Music Production', 'Singing', 'Live Music',
    'Health & Fitness', 'Yoga', 'Gym Workouts', 'Nutrition', 'Mental Health',
    'Fashion', 'Trends', 'Personal Styling', 'Fashion Design', 'Beauty Tips',
    'Travel', 'Adventure Travel', 'City Tours', 'Cultural Experiences', 'Travel Tips',
    'Cooking', 'Recipes', 'Baking', 'Healthy Eating', 'World Cuisines',
    'Pets', 'Dog Care', 'Cat Care', 'Aquariums', 'Bird Keeping',
    'Automobiles', 'Car Enthusiasts', 'Motorcycles', 'Vehicle Maintenance',
    'Science', 'Physics', 'Chemistry', 'Biology', 'Environmental Science',
    'Politics', 'Current Events', 'International Relations', 'Political Theory',
    'Business', 'Startups', 'Entrepreneurship', 'Marketing', 'Finance',
    'Lifestyle', 'Minimalism', 'Luxury Living', 'Rural Living', 'Urban Exploration',
    'Sports', 'Football', 'American Football', 'Soccer', 'Baseball', 'Basketball',
    'Tennis', 'Table Tennis', 'Badminton', 'Golf', 'Rugby', 'Cricket', 'Volleyball',
    'Beach Volleyball', 'Hockey', 'Field Hockey', 'Ice Hockey', 'Lacrosse',
    'Archery', 'Shooting Sports', 'Bowling', 'Boxing', 'Wrestling', 'Martial Arts',
    'Karate', 'Judo', 'Taekwondo', 'Brazilian Jiu-jitsu', 'Muay Thai', 'MMA',
    'Swimming', 'Diving', 'Water Polo', 'Rowing', 'Canoeing', 'Kayaking',
    'Sailing', 'Windsurfing', 'Surfing', 'Stand Up Paddleboarding',
    'Skateboarding', 'Rollerblading', 'Roller Skating', 'BMX', 'Mountain Biking',
    'Cycling', 'Track Cycling', 'Road Cycling', 'Mountain Climbing', 'Rock Climbing',
    'Ice Climbing', 'Hiking', 'Backpacking', 'Skiing', 'Snowboarding', 'Skydiving',
    'Paragliding', 'Hang Gliding', 'Bungee Jumping', 'Parachuting', 'Fencing',
    'Equestrian', 'Polo', 'Rodeo Sports', 'Gymnastics', 'Trampoline', 'Powerlifting',
    'Weightlifting', 'Bodybuilding', 'Aerobics', 'Yoga', 'Pilates', 'Dance Sports',
    'Cheerleading', 'Figure Skating', 'Speed Skating', 'Curling', 'Biathlon',
    'Triathlon', 'Pentathlon', 'Decathlon', 'Heptathlon', 'Squash', 'Racquetball',
    'Handball', 'Snooker', 'Billiards', 'Darts', 'Table Soccer', 'Foosball',
    'Ultimate Frisbee', 'Frisbee Golf', 'Horse Racing', 'Greyhound Racing',
    'Camel Racing', 'Drag Racing', 'Auto Racing', 'Formula 1', 'Rally Racing',
    'Motorcycle Racing', 'Motocross', 'ATV Racing', 'Kart Racing', 'Drone Racing',
    'Adventure Racing', 'Orienteering'
  ].freeze

  belongs_to :user
  has_many :chat_messages
  has_one_attached :avatar 
  has_secure_password validations: false
  validates :category, inclusion: { in: CATEGORIES }
end
