class ExpensesController < ApplicationController

	def index
		data = initial
		render locals: {active_type: data[0], active_cat: data[1], active_date: data[2], message: nil}
	end

	def new
		@types = Type.all
		@categories = Category.all
		@expense = Expense.new
	end

	def create
		@expense = Expense.create(expense_params)
		if @expense.errors.empty?
			concept = @expense.concept.to_s
			edate = @expense.date
			month = edate.strftime("%b").to_s
			year = edate.strftime("%Y").to_s
			amount = @expense.amount.to_s
			@message = "Gasto <strong>" + concept + "</strong> por <strong>" +
				amount.gsub(/(\d)(?=(\d{3})+(?!\d))/, "\\1,")  + 
				"</strong> en <strong>" + month + "-" + year + 
				"</strong> fue adicionado exitosamente"
		end
	end

	def edit
		@types = Type.all
		@categories = Category.all
		@expense = Expense.find(params[:id])
	end

	def update
		@expense = Expense.find(params[:id])
		@expense.update(expense_params)
		if @expense.errors.empty?
			@message = "Gasto actualizado exitosamente"
		end
	end

	def destroy
		expense = Expense.find(params[:id])
		message = "Gasto <strong>" + expense.concept + "</strong> por <strong>" + 
			expense.amount.to_s.gsub(/(\d)(?=(\d{3})+(?!\d))/, "\\1,")  + 
			"</strong> en <strong>" + expense.date.strftime("%b") + "-" + expense.date.strftime("%Y") + 
			"</strong> fue borrado exitosamente"
		if expense.destroy
			data = initial
			render :index, locals: {active_type: data[0], active_cat: data[1], active_date: data[2], 
				message: message.html_safe}
		end
	end

	protected
	def expense_params
		params.require(:expense).permit(:type_id,:category_id,:date,:concept,:amount)
	end

	private
	def initial
		@types = Type.all
		@categories = Category.all

		if params[:type].present?
			type = params[:type]
		else
			type = nil
		end
		
		if params[:cat].present?
			cat = params[:cat]
		else
			cat = nil
		end
		
		if params[:date].present?
			date = params[:date].to_date
		else
			date = Date.today
		end

		@expenses = Expense.expenses_month(date.year,date.month,type,cat,1).order('date DESC')
		data = Array.new()
		data.push type,cat,date
		data
	end
end
