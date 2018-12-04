class AdminController < ApplicationController
  before_action :check_admin

  def check_admin
    unless user_signed_in? && current_user.admin?
      redirect_to root_path
    end
  end

  def index
    @all_users = User.all
    @all_orders = Order.all
    @cats = Item.all
  end

end
