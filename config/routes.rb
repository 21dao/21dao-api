Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope :auctions do
    post '/all', to: 'auctions#all'
    post '/twentyone_dao', to: 'auctions#twentyone_dao'
    post '/all_by_artists', to: 'auctions#all_by_artists'
    post '/sales', to: 'auctions#top_sales'
    post '/buyers', to: 'auctions#top_buyers'
    post '/sellers', to: 'auctions#top_sellers'
  end

  scope :listings do
    post '/all', to: 'listings#all'
  end

  scope :artist do
    post '/by_name', to: 'artist#by_name'
  end

  scope :artists do
    post '/all', to: 'artists#all'
  end
end
