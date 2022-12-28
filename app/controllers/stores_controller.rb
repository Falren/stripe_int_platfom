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
    return render :edit unless @store.update(store_params)

    service = StripeAccount.new(current_user.account)
    service.update_account_branding

    redirect_to store_path
  end

  private

  def store_params
    params.require(:store).permit(:domain, :subdomain, :primary_color, :secondary_color)
  end
end
