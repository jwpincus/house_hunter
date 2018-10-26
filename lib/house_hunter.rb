require 'csv'

class HouseHunter
  attr_reader :houses

  def initialize(interest = 0.04, loan_length = 30, down_payment = 40000, monthly_payment = 3000, squarefeet = 2000, listings_path = './seed_data/loftium_listings_sample.csv')
    @interest = interest
    @loan_length = loan_length
    @down_payment = down_payment
    @monthly_payment = monthly_payment
    @squarefeet = squarefeet
    load_csv(listings_path)
    max_loan_principle
    max_house_price
    min_loan_principle
    min_house_price
    output_results
  end

  def max_loan_principle
    payment = @monthly_payment * 1.05
    @max_principle = loan_principle(payment)
  end

  def min_loan_principle
    payment = @monthly_payment * 0.8
    @min_principle = loan_principle(payment)
  end

  def max_house_price
    max_from_down_payment = (@down_payment * 20)
    max_from_down_payment < (@max_principle + @down_payment) ? max_from_down_payment : @max_principle + @down_payment
  end

  def min_house_price
    min_from_down_payment = (@down_payment * 5)
    min_from_down_payment < (@min_principle + @down_payment) ? min_from_down_payment : @min_principle + @down_payment
  end

  def loan_principle(payment)
    effective_interest =  @interest / 12.0
    principle = (payment / effective_interest) * (1 - (1 + effective_interest)**(-(@loan_length * 12)))
    principle.to_i
  end

  def load_csv(path)
    @houses = []
    CSV.foreach(path, headers: true) do |row|
      @houses << House.new(row['id'], row['source_url'], row['bathrooms'], row['bedrooms'], row['price'], row['squarefeet'], row['mls_id'])
    end
    @houses
  end

  def price_filter(houses = @houses)
    houses.select do |house|
      house.price <= max_house_price && house.price >= min_house_price
    end
  end

  def size_filter(houses = @houses)
    min_size = @squarefeet * 0.9
    houses.select do |house|
      house.squarefeet >= min_size
    end
  end

  def sort_filtered(payment_weighting = 1.0, size_weighting = 1.0, down_weighting = 75.0)
    in_range = price_filter(size_filter)
    in_range.sort_by do |h|
      add_payment_attrs(h)
      ((h.delta_payment * payment_weighting) + (h.delta_size * size_weighting) + (h.delta_down_percent * down_weighting))
    end
  end

  def payment(principal)
    i =  @interest / 12.0
    m = @loan_length * 12.0
    (principal * ((i * ((1 + i)**m)) / (((1 + i)**m) - 1))).round
  end

  def down_percent(price)
    ((@down_payment.to_f / price) * 100.0).round(2)
  end

  def add_payment_attrs(house)
    house.payment = payment(house.price - @down_payment)
    house.down_percent = down_percent(house.price)
    house.delta_payment = (house.payment - @monthly_payment).abs
    house.delta_size = (house.squarefeet - @squarefeet).abs
  end

  def output_results
    CSV.open("./data/#{Time.now}-results.csv", "wb") do |csv|
      csv << [:id, :source_url, :bathrooms, :bedrooms, :price, :squarefeet, :payment, :down_percent]
      sort_filtered.each do |h|
        csv << [h.id, h.source_url, h.bathrooms, h.bedrooms, h.price, h.squarefeet, h.payment, h.down_percent]
      end
    end
  end

end

# Assumptions:
# 1. No upper bound on sq. ft., lower bound 10% lower than requested, but houses will be penalized for going over.
# 2. User will go 5% over on payment, or 20% under.
# 3. User will put all savings down as 5%-20% of house costs
# 4. A house that would have a down payment greater than 20% won't be pnealized in the sort, one with less than 20% will


#  Spec: A user has $40,000 in savings, she would like a maximum monthly mortgage payment around (a) $3,000 per month, (b) would prefer a home with around 2,000 squarefeet and (c) would like to buy homes that give her as much down % possible (e.g. a home with 20% down is optimal compared to 5%). Given the CSV (attached) of homes for sale, can you output homes sorted closest to the user’s preferences in descending order? The output can be of any format you choose (CSV, JSON, HTML, etc.). You can write this recommender in any of: Ruby, Python, Javascript or Java.
