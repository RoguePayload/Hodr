require "test_helper"

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(uname: "The Viking", fname: "Dr. Aubrey", mname: "Wayne", lname: "Love II", tel: "972-872-5054", email: "awlove@aubreylove.space",
    adr1: "404 Hackers BLVD", adr2: "#403", city: "Dallas", state: "Texas", zip: "77548", country: "United States of Failure", git: "https://github.com/AubreyLove",
    twitter: "https://twitter.com/AubreyLove", lin: "https://linkedin.com/in/AubreyLove", web: "https://aubreylove.space", ytube: "https://youtube.com/AubreyLove",
    degree: "Ph.D. Computer Science", sname: "Ashley University", cstudies: "Did school work", marital: "Married", spouse: "Khristane", kids: "4", books: "Ruby on Rails, Coding for Dummies",
    activity: "Coding, Family Time, God Time", songs: "Teach me Lord to Wait", games: "Fortnite, Call of Duty, Halo", jtitle: "Lead Programmer", cname: "Hodr", ljob: "1 Year",
    password: "abc123", password_confirmation: "abc123", bio: "A simple man trying to make it in this world!")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "Username (uname) should be present" do
    @user.uname = "    "
    assert_not @user.valid?
  end

  test "Username (uname) should not be too long" do
    @user.uname = "a" * 51
    assert_not @user.valid?
  end

  test "First Name (fname) should be present" do
    @user.fname = "    "
    assert_not @user.valid?
  end

  test "First Name (fname) should not be too long" do
    @user.fname = "a" * 51
    assert_not @user.valid?
  end

  test "Middle Name (mname) should be present" do
    @user.mname = "    "
    assert_not @user.valid?
  end

  test "Middle Name (mname) should not be too long" do
    @user.mname = "a" * 51
    assert_not @user.valid?
  end

  test "Last Name (lname) should be present" do
    @user.lname = "    "
    assert_not @user.valid?
  end

  test "Last Name (lname) should not be too long" do
    @user.lname = "a" * 51
    assert_not @user.valid?
  end

  test "Telephone (tel) should be present" do
    @user.tel = "    "
    assert_not @user.valid?
  end

  test "Telephone (tel) should not be too long" do
    @user.tel = "a" * 21
    assert_not @user.valid?
  end

  test "Email (email) should be present" do
    @user.email = "    "
    assert_not @user.valid?
  end

  test "Email (email) should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                         foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lowercase" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "Address 1 (adr1) should be present" do
    @user.adr1 = "    "
    assert_not @user.valid?
  end

  test "Address 1 (adr1) should not be too long" do
    @user.adr1 = "a" * 51
    assert_not @user.valid?
  end

  test "Address 2 (adr2) should be present" do
    @user.adr2 = "    "
    assert_not @user.valid?
  end

  test "Address 2 (adr2) should not be too long" do
    @user.adr2 = "a" * 51
    assert_not @user.valid?
  end

  test "City (city) should be present" do
    @user.city = "    "
    assert_not @user.valid?
  end

  test "City (city) should not be too long" do
    @user.city = "a" * 51
    assert_not @user.valid?
  end

  test "State (state) should be present" do
    @user.state = "    "
    assert_not @user.valid?
  end

  test "State (state) should not be too long" do
    @user.state = "a" * 51
    assert_not @user.valid?
  end

  test "Zip (zip) should be present" do
    @user.zip = "    "
    assert_not @user.valid?
  end

  test "Zip (zip) should not be too long" do
    @user.zip = "a" * 21
    assert_not @user.valid?
  end

  test "Country (country) should be present" do
    @user.country = "    "
    assert_not @user.valid?
  end

  test "Country (country) should not be too long" do
    @user.country = "a" * 51
    assert_not @user.valid?
  end

  test "Git Account (git) should be present" do
    @user.git = "    "
    assert_not @user.valid?
  end

  test "Git Account (git) should not be too long" do
    @user.git = "a" * 91
    assert_not @user.valid?
  end

  test "Twitter (twitter) should be present" do
    @user.twitter = "    "
    assert_not @user.valid?
  end

  test "Twitter (twitter) should not be too long" do
    @user.twitter = "a" * 91
    assert_not @user.valid?
  end

  test "LinkedIn (lin) should be present" do
    @user.lin = "    "
    assert_not @user.valid?
  end

  test "LinkedIn (lin) should not be too long" do
    @user.lin = "a" * 91
    assert_not @user.valid?
  end

  test "YouTube (ytube) should be present" do
    @user.ytube = "    "
    assert_not @user.valid?
  end

  test "YouTube (ytube) should not be too long" do
    @user.ytube = "a" * 91
    assert_not @user.valid?
  end

  test "Website (web) should be present" do
    @user.web = "    "
    assert_not @user.valid?
  end

  test "Website (web) should not be too long" do
    @user.web = "a" * 91
    assert_not @user.valid?
  end

  test "Highest Degree (degree) should be present" do
    @user.degree = "    "
    assert_not @user.valid?
  end

  test "Highest Degree (degree) should not be too long" do
    @user.degree = "a" * 91
    assert_not @user.valid?
  end

  test "School Name (sname) should be present" do
    @user.sname = "    "
    assert_not @user.valid?
  end

  test "School Name (sname) should not be too long" do
    @user.sname = "a" * 91
    assert_not @user.valid?
  end

  test "Marital Status (marital) should be present" do
    @user.marital = "    "
    assert_not @user.valid?
  end

  test "Marital Status (marital) should not be too long" do
    @user.marital = "a" * 21
    assert_not @user.valid?
  end

  test "Spouse's Name (spouse) should be present" do
    @user.spouse = "    "
    assert_not @user.valid?
  end

  test "Spouse's Name (spouse) should not be too long" do
    @user.spouse = "a" * 31
    assert_not @user.valid?
  end

  test "Number of Kids (kids) should be present" do
    @user.kids = "    "
    assert_not @user.valid?
  end

  test "Number of Kids (kids) should not be too long" do
    @user.kids = "a" * 91
    assert_not @user.valid?
  end

  test "Books of Interest (books) should be present" do
    @user.books = "    "
    assert_not @user.valid?
  end

  test "Books of Interest (books) should not be too long" do
    @user.books = "a" * 1501
    assert_not @user.valid?
  end

  test "Favorite Movies (movies) should be present" do
    @user.movies = "    "
    assert_not @user.valid?
  end

  test "Favorite Movies (movies) should not be too long" do
    @user.movies = "a" * 1501
    assert_not @user.valid?
  end

  test "Favorite Activity (activity) should be present" do
    @user.activity = "    "
    assert_not @user.valid?
  end

  test "Favorite Activity (activity) should not be too long" do
    @user.activity = "a" * 1501
    assert_not @user.valid?
  end

  test "Favorite Songs (songs) should be present" do
    @user.songs = "    "
    assert_not @user.valid?
  end

  test "Favorite Songs (songs) should not be too long" do
    @user.songs = "a" * 1501
    assert_not @user.valid?
  end

  test "Favorite Games (games) should be present" do
    @user.games = "    "
    assert_not @user.valid?
  end

  test "Favorite Games (games) should not be too long" do
    @user.games = "a" * 1501
    assert_not @user.valid?
  end

  test "Job Title (jtitle) should be present" do
    @user.jtitle = "    "
    assert_not @user.valid?
  end

  test "Job Title (jtitle) should not be too long" do
    @user.jtitle = "a" * 91
    assert_not @user.valid?
  end

  test "Company Name (cname) should be present" do
    @user.cname = "    "
    assert_not @user.valid?
  end

  test "Company Name (cname) should not be too long" do
    @user.cname = "a" * 91
    assert_not @user.valid?
  end

  test "Length at Job (ljob) should be present" do
    @user.ljob = "    "
    assert_not @user.valid?
  end

  test "Length at Job (ljob) should not be too long" do
    @user.ljob = "a" * 91
    assert_not @user.valid?
  end 

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
  end

  test "Biography (bio) should be present" do
    @user.bio = "    "
    assert_not @user.valid?
  end

  test "Biography (bio) should not be too long" do
    @user.bio = "a" * 3501
    assert_not @user.valid?
  end

  test "College Studies (cstudies) should be present" do
    @user.cstudies = "    "
    assert_not @user.valid?
  end

  test "College Studies (cstudies) should not be too long" do
    @user.cstudies = "a" * 1501
    assert_not @user.valid?
  end

end
