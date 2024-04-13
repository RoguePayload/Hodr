# app/services/stripe_service.rb
class StripeService
  def self.create_customer(email, payment_method_id)
    Stripe.api_key = Rails.application.credentials.stripe[:secret_key]
    Stripe::Customer.create({
      email: email,
      payment_method: payment_method_id,
      invoice_settings: {
        default_payment_method: payment_method_id
      }
    })
  end

  def self.create_subscription(customer_id, plan_id)
    Stripe::Subscription.create({
      customer: customer_id,
      items: [{ plan: plan_id }],
      expand: ['latest_invoice.payment_intent']
    })
  end
end
