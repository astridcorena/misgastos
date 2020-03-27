# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Type.create([
	{ typename: "Purchase", color: "#0033cc" },
	{ typename: "Withdrawal", color: "#cc00cc"},
	{ typename: "Transfer", color: "#ff9900"},
	{ typename: "Payment", color: "#009900"},
	{ typename: "Others", color: "#ffff00"}
	])
Category.create([
	{ catname: "Restaurants"},
	{ catname: "Grocery"},
	{ catname: "Car"},
	{ catname: "Services"},
	{ catname: "Home"},
	{ catname: "Education"},
	{ catname: "Fun"},
	{ catname: "Travel"},
	])	

1000.times do
	Expense.create([{
		type_id: Faker::Number.between(1, 5),
		category_id: Faker::Number.between(1, 8),
		date: Faker::Date.between(200.days.ago,60.days.from_now),
		concept: Faker::Commerce.product_name,
		amount: Faker::Number.between(50000,10000000)
		}])
end
