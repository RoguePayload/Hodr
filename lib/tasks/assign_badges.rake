namespace :badges do
  desc "Assign badges to existing users"
  task assign_to_existing_users: :environment do
    User.find_each do |user|
      user.assign_all_badges
    end

    puts "Completed assigning badges to existing users."
  end
end
