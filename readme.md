# House Hunter
## Testing
* Minitest must be installed to run tests.
* From the /house_hunter directory run `ruby test/house_hunter_test.rb`
* From the /house_hunter directory run `ruby test/house_test.rb`
* Tests are dependent on the seed_data CSV, some expectations will fail with different data  

## Assumptions
1. No upper bound on sq. ft., lower bound is 10% lower than requested, but houses will be penalized based on the difference in the sort.
2. User willing to go 5% over on payment, with no limit on under. Houses are penalized for their difference from the preferred payment in the sort.
3. User will put all savings down as 5%-20% of house costs
4. A house that would have a down payment greater than 20% won't be penalized in the sort, one with less than 20% will.
