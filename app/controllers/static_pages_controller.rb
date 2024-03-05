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

  def privacy
  end

  def admin
    @users = User.paginate(page: params[:page], per_page: 10)
    # Data for monthly new user registrations chart
    @new_users_by_month = User.group_by_month(:created_at).count
    @daily_user_activity = Micropost.all.group_by { |micropost| micropost.created_at.to_date }.transform_values(&:count)
    @top_contributors = User.top_contributors(limit: 10)
    @active_users, @inactive_users = User.activity_split
  end
end
