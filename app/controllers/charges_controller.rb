class ChargesController < ApplicationController
  def new
    @charge = Charge.new amount: 500
  end

  def create
    @change = current_user.charges.build charge_params
    customer = Stripe::Customer.create(
      email: current_user.email,
      source: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @charge.amount,
      description: 'Rails stripe test',
      currency: 'jpy'
    )
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  private

    def charge_params
      params.reuqire(:charge).permit(:amount)
    end
end
