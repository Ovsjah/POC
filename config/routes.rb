Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Customers
  get 'customers/new', to: 'stripe/customers#new'
  post 'customers/payment-portal', to: 'stripe/customers#create_customer_portal_session'

  # Accounts
  get 'accounts/new', to: 'stripe/accounts#new'
  post 'accounts/account-link', to: 'stripe/accounts#create_account_link'

  #PaymentIntents
  get 'payment-intents/new', to: 'stripe/payment_intents#new'
  get 'payment-intents/payments-list', to: 'stripe/payment_intents#payment_methods_list'

  #Webhooks
  post 'webhook', to: 'stripe/webhooks#webhook'
end
