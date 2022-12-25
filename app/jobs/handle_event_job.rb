class HandleEventJob < ApplicationJob
  queue_as :default

  def perform(event)
    case event.source
    when 'stripe'
      handle_stipe_event(event)
    end
  end

  def handle_stipe_event(event)
    stripe_event = Stripe::Event.construct_from(event.data)
    case stripe_event.type
    when 'customer.created'
      handle_customer_created(stripe_event)
    when 'account.updated'
      handle_account_updated(stripe_event)
    end
  end

  def handle_account_updated(stripe_event)
    stripe_account = stripe_event.data.object
    account = Account.find_by(stripe_id: stripe_account.id)
    account.update(
      charges_enabled: stripe_account.charges_enabled,
      payouts_enabled: stripe_account.payouts_enabled
    )
  end

  def handle_customer_created(stripe_event)
    puts "customer.created #{stripe_event.data.object.id}"
  end
end
