class House
  attr_reader :id, :source_url, :bathrooms, :bedrooms, :price, :squarefeet, :mls_id

  def initialize(id = nil, source_url = nil, bathrooms = nil, bedrooms = nil, price = nil, squarefeet = nil, mls_id = nil)
    @id = id
    @source_url = source_url
    @bathrooms = bathrooms.to_f
    @bedrooms = bedrooms.to_i
    @price = price.to_i
    @squarefeet = squarefeet.to_i
    @mls_id = mls_id
  end

end
