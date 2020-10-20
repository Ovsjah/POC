class Stripe::CustomersController < ApplicationController
  def new
    render json: Stripe::Customer.create(customer_params.to_h)
  end

  def create_customer_portal_session
    render json: Stripe::BillingPortal::Session.create(customer_params.to_h), status: :created
  end

  def customer_source_created_webhook
    puts "Hello from CUSTOMER SOURCE CREATED WEBHOOK!"
  end

  private

    def customer_params
      params.require(:customer).permit(:email, :description, :customer, :return_url)
    end
end
