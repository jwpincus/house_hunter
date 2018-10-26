# House Hunter
## Testing
* Minitest must be installed to run tests.
* From the /house_hunter directory run `ruby test/house_hunter_test.rb`
* From the /house_hunter directory run `ruby test/house_test.rb`
* Tests are dependent on the seed_data CSV, some expectations will fail with different data  


## Basic Design Spec:
* A user has $40,000 in savings
* She would like a maximum monthly mortgage payment around $3,000 per month
* Would prefer a home with around 2,000 squarefeet and
* Would like to buy homes that give her as much down % possible (e.g. a home with 20% down is optimal compared to 5%).

Given the CSV (attached) of homes for sale, can you output homes sorted closest to the user’s preferences in descending order?



## Assumptions
1. No upper bound on sq. ft., lower bound is 10% lower than requested, but houses will be penalized based on the difference in the sort whether over or under.
2. User willing to go 5% over on payment, with no limit on under. Houses are penalized for their difference from the preferred payment in the sort.
3. User will put all savings down as 5%-20% of house costs
4. A house that would have a down payment greater than 20% won't be penalized in the sort, one with less than 20% will.
