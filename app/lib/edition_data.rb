module EditionData
  def self.extract(data)
    edition_data = {}
    data = Base64.decode64(data)
    edition_data[:type] = data[0].ord
    edition_data[:name] = edition_types[data[0].ord]
    # Master Edition
    if (data[0].ord == 2 || data[0].ord == 6) && data[9]&.ord != 0
      edition_data[:max_supply] = data[10..17].unpack1('I*')
      edition_data[:supply] = data[1..8].unpack1('I*')
    end
    if data[0].ord == 1
      edition_data[:parent] = Btc::Base58.base58_from_data(data[1..32].unpack('H*').pack('H*'))
      edition_data[:number] = data[33..40].unpack1('I*')
    end
    edition_data
  end

  def self.edition_types
    [
      'Uninitialized',
      'Edition',
      'Master Edition',
      'Reservation List',
      'Metadata',
      'Reservation List',
      'Master Edition',
      'Edition Marker'
    ]
  end
end
