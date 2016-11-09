Stripe.api_key = Settings.stripe.secret_key

StripeEvent.configure do |events|
  events.subscribe 'charge.failed' do |event|
    # Define subscriber behavior based on the event object
    event.class       #=> Stripe::Event
    event.type        #=> "charge.failed"
    event.data.object #=> #<Stripe::Charge:0x3fcb34c115f8>
  end

  events.all do |event|
    # Handle all event types - logging, etc.

    Rails.logger.debug "********** Stripe Events start **********"
    Rails.logger.debug event
    Rails.logger.debug "********** Stripe Events end **********"
  end
end
