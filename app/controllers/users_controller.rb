class UsersController < ApplicationController
  def update
    current_user.transaction do
      if current_user.stripe_customer_token.blank?
        stripe_customer = Stripe::Customer.create(
          email: current_user.email,
          plan: Plan.find(params[:user][:plan_id]).stripe_plan_id,
          source: params[:stripeToken]
        )

        current_user.update stripe_customer_token: stripe_customer.id
      end

      

      current_user.update user_params
    end

    redirect_to new_charge_path
  end

  private

    def user_params
      params.require(:user).permit(:plan_id)
    end
end
