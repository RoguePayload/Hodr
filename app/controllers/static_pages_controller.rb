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
  end 
end
