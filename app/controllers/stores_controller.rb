class StoresController < ApplicationController
  layout 'application'
  def show
    @store = current_user.store
  end

  def edit
    @store = current_user.store
  end

  def update
    @store = current_user.store
    return redirect_to store_path if @store.update(store_params)

    render :edit
  end

  private

  def store_params
    params.require(:store).permit(:domain, :subdomain, :primary_color, :secondary_color)
  end
end