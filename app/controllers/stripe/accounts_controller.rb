class Stripe::AccountsController < ApplicationController
  # triggers capability.updated event if the list of capabilities is provided in params
  def new
    render json: Stripe::Account.create(account_params.to_h)
  end

  # triggers account updated during onbording
  def create_account_link
    render json: Stripe::AccountLink.create(account_params.to_h), status: :created
  end

  private

    def account_params
      params.require(:account).permit(:account, :refresh_url, :return_url,
                                      :type, :country, :email, business_profile: {}, capabilities: {})
    end
end
