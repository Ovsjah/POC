require 'rest-client'
require 'json'

# Customer
customer_params = {
  email: "ovsjah@yahoo.com",
  description: "Stinky customer wanna POC"
}
new_customer_resp = RestClient.get 'http://localhost:3000/customers/new', params: { customer: customer_params }
puts "NEW CUSOMER => #{new_customer_resp.body}"

customer_id = JSON.parse(new_customer_resp.body)['id']
portal_session_resp = RestClient.post 'http://localhost:3000/customers/payment-portal',
                                      customer: {
                                        customer: customer_id,
                                        return_url: "https://dashboard.stripe.com/test/customers"
                                      }
puts "PORTAL SESSION => #{portal_session_resp.body}"

#Account
account_params = {
  type: 'custom',
  country: 'US',
  email: 'ovsjah@yahoo.com',
  business_profile: {
    name: "Stinky Charity",
    product_description: "POC charity that stinks!"
  },
  capabilities: {
    card_payments: {requested: true},
    transfers: {requested: true}
  }
}
new_account_resp = RestClient.get 'http://localhost:3000/accounts/new', params: { account: account_params }
puts "NEW ACCOUNT => #{new_account_resp.body}"
account_id = JSON.parse(new_account_resp.body)['id']
account_session_resp = RestClient.post 'http://localhost:3000/accounts/account-link',
                                        account: {
                                          account: account_id,
                                          refresh_url: "https://dashboard.stripe.com/test/connect/accounts/overview",
                                          return_url: "https://dashboard.stripe.com/test/connect/accounts/overview",
                                          type: 'account_onboarding'
                                        }
puts "ACCOUNT SESSION => #{account_session_resp.body}"

#PaymentIntent

# params for receiving the payment_methods_list
# payment_methods_list_params = {
#   type: 'card',
#   customer: customer_id
# }
# payment_methods_list_resp = RestClient.get 'http://localhost:3000/payment-intents/payments-list', params: { payment_intent: payment_methods_list_params }
# puts "PAYMENTMETHODS LIST => #{payment_methods_list_resp}"
#
# payment_method_id = JSON.parse(payment_methods_list_resp.body)['data'].first['id']

payment_method_id = 'card_1HeULCAOfbpcepXDqnnpV1c3'

payment_intent_params = {
  confirm: true,
  amount: 100000,
  currency: 'usd',
  customer: customer_id,
  application_fee_amount: 50000,
  payment_method_types: ['card'],
  payment_method: payment_method_id, # you should get it from customer's payment methods section for fresh account
  transfer_data: {
    destination: account_id
  }
}
new_payment_intent_resp = RestClient.get 'http://localhost:3000/payment-intents/new', params: { payment_intent: payment_intent_params }
puts "PAYMENT INTENT => #{new_payment_intent_resp.body}"
