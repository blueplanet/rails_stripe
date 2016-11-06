class UserController < ApplicationController
  def update
    if current_user.stripe_customer_token.blank?
      stripe_customer = Stripe::Customer.create(
        email: current_user.email,
        plan: params[:user][:plan_id]
        source: params[:stripeToken]
      )

      current_user.update stripe_customer_token: customer.id
    end
  end
end
