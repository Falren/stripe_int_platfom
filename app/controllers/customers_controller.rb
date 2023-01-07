class CustomersController < ApplicationController
  def index
    @customers = current_user.store.customers
  end

  def show
    @customer = current_user.store.customers.find(params[:id])
  end
end
