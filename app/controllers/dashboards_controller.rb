class DashboardsController < ApplicationController
  def show
    return if current_user.account.nil?

    @financial_balances = StripeAccount.new(current_user.account).financial_balances
    @payments_balances = StripeAccount.new(current_user.account).payments_balances
  end
end
