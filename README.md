# Overview

As it stands our site can be broken down into 3 main areas:

1. Auction leaderboard
2. Artist listing and live auctions/secondary listings for artists in the DAO
3. An artist Gallery that fetches NFT's by creator address and then allows curating to create a gallery of all the artists work.

## Solana Indexer

We are running the opensource solana-index from Holaplex to retrieve Holaplex auction and sales data

## Workers

[21dao-workers](https://github.com/21dao/21dao-workers)
Our workers fetch the following data:

1. Holaplex via the solana-indexer
2. Exchange.Art via API
3. Formfunction via API

## API

[21dao-api](https://github.com/21dao/21dao-api)
Our API serves the data collected by our workers and provides the backend for our artist gallery.

## Frontend

[21dao-react](https://github.com/21dao/21dao-react)
The frontend is written in React and created using create-react-app and deployed as a static site.

## Community Sample App

[community-sample-app](https://github.com/21dao/community-sample-app)
This is a static React app that other communities can use to bootstrap their own site and provides Artist listings as well as live auction and secondary sales pages for community members.

# Testing

For testing we suggest running the API with seed data and the frontend.

## API

The API is an api only Ruby on Rails application.

1. Install ruby 3.0.2
2. Install bundler `gem install bundler`
3. Create database and edit `config/database.yml`
4. Run db migrations `bundle exec rake db:migrate`
5. Seed the db `bundle exec rake db:seed`
6. Start the server `bundle exec rails s -p 3001`

## Frontend

1. `yarn install`
2. `yarn run dev`
