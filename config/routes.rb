Rails.application.routes.draw do

  root 'dashboard#step1'

  get 'dashboard/step1', to: 'dashboard#step1'
  post 'dashboard/send_money', to: 'dashboard#send_money'

end
