class SubscriptionsController < ApplicationController
  # GET /subscriptions/new
  def new
    # Assuming you might need some setup before showing the form
    # For example, listing available plans
  end

  # POST /subscriptions
  class SubscriptionsController < ApplicationController
    def create
      if current_user.admin?
        # Handle admin user, bypassing payment
        current_user.update(
          is_premium: true, # Assume you have a flag to mark premium access
          stripe_customer_id: "admin-no-payment-required",
          stripe_subscription_id: "admin-access-granted"
        )
        redirect_to root_path, notice: "Admin access granted with all premium features."
      else
        # Normal user payment process
        customer = Stripe::Customer.create({
          email: current_user.email,
          source: params[:stripeToken]
        })

        subscription = Stripe::Subscription.create({
          customer: customer.id,
          items: [{ plan: params[:plan_id] }],
        })

        if subscription.status == 'active'
          current_user.update(
            stripe_customer_id: customer.id,
            stripe_subscription_id: subscription.id
          )
          redirect_to root_path, notice: "Subscription created successfully!"
        else
          redirect_to new_subscription_path, alert: "Failed to create subscription."
        end
      end
    rescue Stripe::StripeError => e
      redirect_to new_subscription_path, alert: "Error: #{e.message}"
    end
  end




end
