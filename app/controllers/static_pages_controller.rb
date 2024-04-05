class StaticPagesController < ApplicationController
  before_action :admin_user,     only: :destroy

  def home
     @micropost = current_user.microposts.build if logged_in?
  end

  def about
  end

  def howto
  end

  def contact
  end

  def send_contact
    # Logic to handle contact form submission, e.g., sending an email
    ContactMailer.contact_email(contact_params).deliver_now
    redirect_to contact_path, notice: "Your message has been sent successfully."
  end

  def eula
  end

  def privacy
  end

  def admin
    @users = User.paginate(page: params[:page], per_page: 10)
    @businesses = Business.paginate(page: params[:page], per_page: 10)
    @ads = Ad.paginate(page: params[:page], per_page: 10)
    @new_users_by_month = User.group_by_month(:created_at).count
    @daily_user_activity = Micropost.all.group_by { |micropost| micropost.created_at.to_date }.transform_values(&:count)
    @top_contributors = User.top_contributors(limit: 10)
    @active_users_count = User.active.count
    @inactive_users_count = User.inactive.count
    @active_businesses_count = Business.active.count
    @inactive_businesses_count = Business.inactive.count
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end

end
