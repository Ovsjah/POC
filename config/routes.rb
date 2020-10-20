Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Customers
  get 'customers/new', to: 'stripe/customers#new'
  post 'customers/payment-portal', to: 'stripe/customers#create_customer_portal_session'
  post 'customers/customers-source-created-webhook', to: 'stripe/customers#customer_source_created_webhook'

  # Accounts
  get 'accounts/new', to: 'stripe/accounts#new'
  post 'accounts/account-link', to: 'stripe/accounts#create_account_link'
  post 'accounts/account-updated-webhook', to: 'stripe/accounts#account_updated_webhook'

  #PaymentIntents
  get 'payment-intents/new', to: 'stripe/payment_intents#new'
  post 'payment-intents/charge-updated-webhook', to: 'stripe/payment_intents#charge_updated_webhook'
end
