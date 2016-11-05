class ChargesController < ApplicationController
  def new
    @charge = Charge.new amount: 500
  end

  def create
    current_user.transaction do
      @charge = current_user.charges.build charge_params

      if current_user.stripe_customer_token.blank?
        customer = Stripe::Customer.create(
          email: current_user.email,
          source: params[:stripeToken]
        )
        current_user.update stripe_customer_token: customer.id
      end

      charge = Stripe::Charge.create(
        customer: current_user.stripe_customer_token,
        amount: @charge.amount,
        description: 'Rails stripe test',
        currency: 'jpy'
      )
      @charge.data = charge.to_json
      @charge.save!
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  private

    def charge_params
      params.require(:charge).permit(:amount)
    end
end
