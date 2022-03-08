Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope :auctions do
    post '/all', to: 'auctions#all'
    post '/all_by_artists', to: 'auctions#all_by_artists'
    post '/sales', to: 'auctions#top_sales'
    post '/buyers', to: 'auctions#top_buyers'
    post '/ending', to: 'auctions#ending_soon'
    post '/sellers', to: 'auctions#top_sellers'
  end
end
