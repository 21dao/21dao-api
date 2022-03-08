Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope :auctions do
    post '/all', to: 'auctions#live_auctions'
    post '/sales', to: 'auctions#top_sales'
    post '/buyers', to: 'auctions#top_buyers'
    post '/ending', to: 'auctions#ending_soon'
    post '/sellers', to: 'auctions#top_sellers'
    post '/highest_bid', to: 'auctions#highest_bid'
    post '/most_bids', to: 'auctions#most_bids'
  end
end
