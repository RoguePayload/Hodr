namespace :badges do
  desc "Update badges for existing users"
  task update: :environment do
    User.find_each do |user|
      user.assign_all_badges
    end

    puts "Completed updating badges for existing users."
  end
end
