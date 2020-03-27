# == Schema Information
#
# Table name: expenses
#
#  id          :integer          not null, primary key
#  type_id     :integer
#  category_id :integer
#  date        :date
#  concept     :string
#  amount      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class ExpenseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should not save expense without type" do
  	category = Category.first
  	expense = Expense.new
  	expense.category_id = category.id
  	expense.date = Date.today
  	expense.concept =  "Concepto de Prueba"
  	expense.amount = 150000

  	assert_not expense.save, "Saved the expense without a type"
  end

  test "should not save expense without category" do
  	type = Type.first
  	expense = Expense.new
  	expense.type_id = type.id
  	expense.date = Date.today
  	expense.concept =  "Concepto de Prueba"
  	expense.amount = 150000

  	assert_not expense.save, "Saved the expense without a category"
  end

  test "should not save expense without a valid concept (minimum 5 characters)" do
  	type = Type.first
  	category = Category.first
  	expense = Expense.new
  	expense.type_id = type.id
  	expense.category_id = category.id
  	expense.date = Date.today
  	expense.concept =  "Pru"
  	expense.amount = 150000

  	assert_not expense.save, "Saved the expense without a valid concept"
  end

  test "should not save expense without a date" do
  	type = Type.first
  	category = Category.first
  	expense = Expense.new
  	expense.type_id = type.id
  	expense.category_id = category.id
  	expense.concept =  "Concepto de Prueba"
  	expense.amount = 150000

  	assert_not expense.save, "Saved the expense without a date"
  end

  test "should not save expense without an amount" do
  	type = Type.first
  	category = Category.first
  	expense = Expense.new
  	expense.type_id = type.id
  	expense.category_id = category.id
  	expense.concept =  "Concepto de Prueba"
  	
  	assert_not expense.save, "Saved the expense without an amount"
  end

  test "sums for expenses in a month have to be correct" do
  	sum01 = Expense.expenses_month(2018,3)
  	sum02 = Expense.where("date between ? and ?", '2018-03-01', '2018-03-31').sum("amount")

  	assert_equal sum01, sum02, "Sums are different (method an query)"
  end
end
