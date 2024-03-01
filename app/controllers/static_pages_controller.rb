class StaticPagesController < ApplicationController
  def home
     @micropost = current_user.microposts.build if logged_in?
  end

  def about
  end

  def howto
  end

  def contact
  end

  def eula
  end

  def admin
    @users = User.paginate(page: params[:page], per_page: 10)
    # Data for monthly new user registrations chart
    @new_users_by_month = User.group_by_month(:created_at).count
    #@daily_user_activity = Micropost.group_by_day(:created_at, last: 30).count
  end
end
