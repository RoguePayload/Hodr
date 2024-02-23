require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
      @user = users(:aubrey)
  end

  test "unsuccessful edit" do
      log_in_as(@user)
      get edit_user_path(@user)
      assert_template 'users/edit'
      patch user_path(@user), params: { user: { uname: "",
                                                fname: "",
                                                mname: "",
                                                lname: "",
                                                bio: "",
                                                tel: "",
                                                adr1: "",
                                                adr2: "",
                                                city: "",
                                                state: "",
                                                country: "",
                                                zip: "",
                                                git: "",
                                                ytube: "",
                                                twitter: "",
                                                lin: "",
                                                web: "",
                                                degree: "",
                                                sname: "",
                                                cstudies: "",
                                                marital: "",
                                                spouse: "",
                                                kids: "",
                                                books: "",
                                                movies: "",
                                                activity: "",
                                                songs: "",
                                                games: "",
                                                jtitle: "",
                                                cname: "",
                                                ljob: "",
                                                jdesc: "",
                                                email: "awlove@aubreylove",
                                                password:              "abc",
                                                password_confirmation: "123" } }
      assert_template 'users/edit'
    end

    test "successful edit with friendly forwarding" do
      get edit_user_path(@user)
      log_in_as(@user)
      assert_redirected_to edit_user_url(@user)
      uname  = "The Viking"
      fname = "Dr. Aubrey"
      mname = "Wayne"
      lname = "Love II"
      tel = "972-555-0505"
      adr1 = "404 Coder BLVD"
      adr2 = "403"
      city = "Dallas"
      state = "Texas"
      zip = "78504"
      country = "United States of Lies"
      git = "https://git.com/AubreyLove"
      lin = "https://linkedin.com/in/AubreyLove"
      web = "https://aubreylove.space"
      ytube = "https://youtube.com/AubreyLove"
      twitter = "https://twitter.com/AubreyLove"
      degree = "Ph.D. Computer Science"
      sname = "Ashley University"
      cstudies = "Did my school work"
      marital = "Married"
      spouse = "My Angel"
      kids = "4"
      books = "Bible, Red Team for Dummies, Cyber Security Guide, Advanced Penetration Testing, Ruby on Rails"
      movies = "Hackers, Passion of the Christ, Coneheads"
      activity = "Hacking, Coding, spending time with family"
      songs = "Teach me Lord to wait"
      games = "Halo, Fortnite, Call of Duty"
      jtitle = "Ruby on Rails Programmer"
      cname = "Hodr"
      ljob = "1 Year"
      jdesc = "Write Code"
      email = "awlove@aubreylove.space"
      bio = "Coding hard, having fun with family"
      patch user_path(@user), params: { user: { uname:  uname,
                                                fname: fname,
                                                mname: mname,
                                                lname: lname,
                                                tel: tel,
                                                adr1: adr1,
                                                adr2: adr2,
                                                city: city,
                                                state: state,
                                                country: country,
                                                zip: zip,
                                                git: git,
                                                lin: lin,
                                                web: web,
                                                ytube: ytube,
                                                twitter: twitter,
                                                degree: degree,
                                                sname: sname,
                                                cstudies: cstudies,
                                                marital: marital,
                                                spouse: spouse,
                                                kids: kids,
                                                books: books,
                                                movies: movies,
                                                activity: activity,
                                                songs: songs,
                                                games: games,
                                                jtitle: jtitle,
                                                cname: cname,
                                                ljob: ljob,
                                                jdesc: jdesc,
                                                email: email,
                                                bio: bio,
                                                password:              "",
                                                password_confirmation: "" } }
      assert_not flash.empty?
      assert_redirected_to @user
      @user.reload
      assert_equal uname,  @user.uname
      assert_equal fname, @user.fname
      assert_equal mname, @user.mname
      assert_equal lname, @user.lname
      assert_equal tel, @user.tel
      assert_equal email, @user.email
      assert_equal adr1, @user.adr1
      assert_equal adr2, @user.adr2
      assert_equal city, @user.city
      assert_equal state, @user.state
      assert_equal zip, @user.zip
      assert_equal country, @user.country
      assert_equal git, @user.git
      assert_equal twitter, @user.twitter
      assert_equal lin, @user.lin
      assert_equal ytube, @user.ytube
      assert_equal web, @user.web
      assert_equal degree, @user.degree
      assert_equal sname, @user.sname
      assert_equal cstudies, @user.cstudies
      assert_equal marital, @user.marital
      assert_equal spouse, @user.spouse
      assert_equal kids, @user.kids
      assert_equal books, @user.books
      assert_equal movies, @user.movies
      assert_equal activity, @user.activity
      assert_equal songs, @user.songs
      assert_equal games, @user.games
      assert_equal jtitle, @user.jtitle
      assert_equal cname, @user.cname
      assert_equal ljob, @user.ljob
      assert_equal jdesc, @user.jdesc
      assert_equal bio, @user.bio
    end
end
