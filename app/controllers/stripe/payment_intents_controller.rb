class Stripe::PaymentIntentsController < ApplicationController
  # the webhook with event type charge.updated is never called!

  # triggers payment.created, transfer.created, charge.succeeded, payment_intent.created, payment_intent.succeeded
  def new
    render json: Stripe::PaymentIntent.create(payment_intent_params.to_h)
  end

  def payment_methods_list
    render json: Stripe::PaymentMethod.list(payment_intent_params.to_h)
  end

  private

    def payment_intent_params
      params.require(:payment_intent).permit(
        :application_fee_amount,
        :customer, :amount, :type,
        :currency, :payment_method, :confirm,
        payment_method_types: [], transfer_data: {}
       )
    end
end
