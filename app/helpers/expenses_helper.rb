module ExpensesHelper

	def modal_button
		@expense.new_record? ? "Crear gasto" : "Modificar Gasto"
	end

end
