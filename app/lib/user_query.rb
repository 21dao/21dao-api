module UserQuery
  Nfts = Holaplex::Client.parse <<-'GRAPHQL'
    query($address: PublicKey!) {
      nfts(creators: [$address], limit: 1000, offset: 0){
        name
        mintAddress
        image
        description
      }
    }
  GRAPHQL
end
