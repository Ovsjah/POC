class Stripe::AccountsController < ApplicationController
  def new
    render json: Stripe::Account.create(account_params.to_h)
  end

  def create_account_link
    render json: Stripe::AccountLink.create(account_params.to_h), status: :created
  end

  def account_updated_webhook
    puts "Hello from ACCOUNT UPDATED WEBHOOK!"
  end

  private

    def account_params
      params.require(:account).permit(:account, :refresh_url, :return_url,
                                      :type, :country, :email, business_profile: {}, capabilities: {})
    end
end
