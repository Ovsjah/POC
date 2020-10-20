class Stripe::CustomersController < ApplicationController
  # the webhook with event type customer.source.created is never called!
  
  # triggers customer.created event
  def new
    render json: Stripe::Customer.create(customer_params.to_h)
  end

  # adding the payment method after proceeding to billing customer link triggers setup_intent.created, payment_method.attached, setup_intent.succeeded, customer.updated events
  def create_customer_portal_session
    render json: Stripe::BillingPortal::Session.create(customer_params.to_h), status: :created
  end

  private

    def customer_params
      params.require(:customer).permit(:email, :description, :customer, :return_url)
    end
end
