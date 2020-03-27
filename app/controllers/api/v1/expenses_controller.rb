class Api::V1::ExpensesController < ApplicationController
	protect_from_forgery with: :null_session

	# get
	def index
		if params[:category_id].present?
			cat = params[:category_id]
		else
			cat =  '%'
		end
		
		if params[:type_id].present?
			type = params[:type_id]
		else
			type =  '%'
		end

		@expenses =  Expense.where('category_id like ? AND type_id like ?',cat,type)

		render json: @expenses,  status: :ok
	end

	# post
	def create
		@expense = Expense.create(expense_params)

		if @expense.save
			render json: @expense, status: :created
		else
			render json: @expense.errors, status: :unprocessable_entity
		end
	end

	#patch
	def update
		@expense = Expense.find(params[:id])
		if @expense.update(expense_params)
			render json: @expense, status: :ok
		else
			render json: @expense.errors, status: :unprocessable_entity
		end
	end

	#delete
	def destroy
		expense = Expense.find(params[:id])
		expense.destroy

		head :no_content
	end

	private
    def expense_params
      params.permit(:type_id, :category_id, :date, :concept, :amount)
    end

end