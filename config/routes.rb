Rails.application.routes.draw do
  resources :accounts, only: %i(create destroy show) do
    resource :wallet, only: [] do
      put ':type' => 'wallets#update'
      post 'change' => 'wallets#change'
    end
  end
end
