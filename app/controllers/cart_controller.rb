class CartController < ApplicationController
  before_action :check_user

  def check_user
    unless user_signed_in?
      redirect_to root_path
    end
  end

  def index
    @current_cart = Cart.find(current_user.id)

    # Find total of each item in cart.
    # A modifier si possible en méthode à part
    @total_price = []
    item_price = @current_cart.items
    item_price.each do |f|
      f.price
      @total_price << f.price
    end
    @final_price = @total_price.sum.round(2)
    @amount = (@final_price * 100).round
  end

  def create
    @current_cart = Cart.find(current_user.id)
    @cart_item = Item.find(params[:cat_id])
    @current_cart.items << @cart_item
    redirect_to home_index_path
  end

  def destroy
    @current_cart = Cart.find(current_user.id)
    @cart_item = Item.find(params[:id])
    number_of_cats = @current_cart.items.where(id: @cart_item).count
    
    #Supprimer l'item du cart
    @current_cart.items.delete(@cart_item)
    redirect_to cart_index_path
  end

  def empty
    @current_cart = Cart.find(current_user.id)
    @current_cart.items.destroy(@current_cart.items)
    redirect_to cart_index_path
  end

end
