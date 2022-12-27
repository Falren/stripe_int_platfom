class DashboardsController < ApplicationController
  def show
    @financial_balances = StripeAccount.new(current_user.account).financial_balances
    @payments_balances = StripeAccount.new(current_user.account).payments_balances
  end
end
