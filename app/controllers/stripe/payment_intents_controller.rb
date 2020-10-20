class Stripe::PaymentIntentsController < ApplicationController
  def new
    render json: Stripe::PaymentIntent.create(payment_intent_params.to_h)
  end

  def charge_updated_webhook
    puts "Hello from CHARGE UPDATED WEBBHOOK!"
  end

  private

    def payment_intent_params
      params.require(:payment_intent).permit(
        :customer, :amount,
        :application_fee_amount,
        :currency, :payment_method, :confirm,
        payment_method_types: [], transfer_data: {}
       )
    end
end
