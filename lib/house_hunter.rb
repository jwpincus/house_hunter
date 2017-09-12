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
    max_from_down_payment = (@down_payment * 20) + @down_payment
    max_from_down_payment < (@max_principle + @down_payment) ? max_from_down_payment : @max_principle + @down_payment
  end

  def min_house_price
    min_from_down_payment = (@down_payment * 20) + @down_payment
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

end

# Assumptions:
# 1. No upper bound on sq. ft.
# 2. can go 5% over on payment, or 20% under


#  Spec: A user has $40,000 in savings, she would like a maximum monthly mortgage payment around (a) $3,000 per month, (b) would prefer a home with around 2,000 squarefeet and (c) would like to buy homes that give her as much down % possible (e.g. a home with 20% down is optimal compared to 5%). Given the CSV (attached) of homes for sale, can you output homes sorted closest to the user’s preferences in descending order? The output can be of any format you choose (CSV, JSON, HTML, etc.). You can write this recommender in any of: Ruby, Python, Javascript or Java.
