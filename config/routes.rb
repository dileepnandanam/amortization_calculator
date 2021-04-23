Rails.application.routes.draw do
  root to: 'amortization#home'
  post '/calculate', to: 'amortization#calculate'
end
