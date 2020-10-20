class ApplicationController < ActionController::API
  before_action :add_stripe_key
  
  private

    def add_stripe_key
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    end
end
