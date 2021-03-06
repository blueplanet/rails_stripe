class UsersController < ApplicationController
  def update
    current_user.transaction do
      if params[:commit] == '保存する'
        if current_user.stripe_customer_token.blank?
          stripe_customer = Stripe::Customer.create(
            email: current_user.email,
            plan: Plan.find(params[:user][:plan_id]).stripe_plan_id,
            source: params[:stripeToken]
          )

          card = stripe_customer.sources.data.find { |c| c.id == stripe_customer.default_source }

          current_user.update(
            stripe_customer_token: stripe_customer.id,
            plan_id: params[:user][:plan_id],
            card_token: stripe_customer.default_source,
            card_brand: card.brand,
            last4: card.last4,
            exp_year: card.exp_year,
            exp_month: card.exp_month,
            stripe_sub_token: stripe_customer.subscriptions.first.id
          )
        else
          stripe_customer = Stripe::Customer.retrieve(current_user.stripe_customer_token)
          stripe_customer.plan = Plan.find(params[:user][:plan_id]).stripe_plan_id
          stripe_customer.save

          current_user.update(
            plan_id: params[:user][:plan_id],
            stripe_sub_token: stripe_customer.subscriptions.first.id
          )
        end
      elsif params[:commit] == '課金をキャンセル'
        subscription = Stripe::Subscription.retrieve(current_user.stripe_sub_token)
        subscription.delete

        current_user.update plan_id: nil, stripe_sub_token: nil
      end
    end

    redirect_to new_charge_path
  end

  private

    def user_params
      params.require(:user).permit(:plan_id)
    end
end
