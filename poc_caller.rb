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
                                        return_url: "https://www.southparkstudios.com/"
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
  },
  requested_capabilities: ['card_payments', 'transfers']
}

new_account_resp = RestClient.get 'http://localhost:3000/accounts/new', params: { account: account_params }
puts "NEW ACCOUNT => #{new_account_resp.body}"
account_id = JSON.parse(new_account_resp.body)['id']
account_session_resp = RestClient.post 'http://localhost:3000/accounts/account-link',
                                        account: {
                                          account: account_id,
                                          refresh_url: "https://www.theodinproject.com/",
                                          return_url: "https://www.southparkstudios.com/",
                                          type: 'account_onboarding'
                                        }
puts "ACCOUNT SESSION => #{account_session_resp.body}"

#PaymentIntent
payment_intent_params = {
  amount: 100000,
  confirm: true,
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
