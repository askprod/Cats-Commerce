class HomeController < ApplicationController

  def index
    @cats = Item.all
    
    # Adds cart when user logs-in
    if signed_in? && !current_user.cart
      @cart = Cart.new(id: current_user.id, name: "My Cart")
      current_user.cart = @cart
      @cart.save
    end

  end

  def show
    @cat_name = Item.find_by_title("#{params[:id].capitalize}")
    @cat_id = Item.find(@cat_name.id)
  end

  def create
    @create_cat = Item.new(title: params[:new][:title].downcase.capitalize, description: params[:new][:description], price: params[:new][:price], picture: params[:new][:picture])
      
      if @create_cat.save!
        redirect_to admin_index_path
      else
        redirect_to new_home_path
      end
  end

  def destroy
    @current_cat = Item.find(params[:id])
    @current_cat.delete
    redirect_to home_index_path
  end 
  
end
