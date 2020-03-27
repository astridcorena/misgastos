require 'test_helper'

class ExpensesControllerTest < ActionDispatch::IntegrationTest
  
  setup do
  	@expense = expenses(:one)
  end

  test "Should get index" do
  	get expenses_path
  	assert_response :success
  	assert_not_nil assigns(:types)
  	assert_not_nil assigns(:categories)
  	assert_not_nil assigns(:expenses) 
  end

  test "Should create an expense" do
  	assert_difference "Transaction.count" do
  		post expenses_path, params: { expense: {type_id: @expense.type_id,  category_id: @expense.category_id, date: @expense.date, concept: @expense.concept, amount: @expense.amount }}
  	end

  	#assert_redirected_to expenses_path
  end
end