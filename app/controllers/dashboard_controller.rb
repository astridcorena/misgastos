class DashboardController < ApplicationController
	def index
    	@expenses = Expense.all
  	end
end
