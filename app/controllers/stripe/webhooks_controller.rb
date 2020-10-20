class Stripe::WebhooksController < ApplicationController
  def webhook
    puts ">>> Hello from #{params[:type]}!"
  end
end
