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

class Expense < ApplicationRecord
	belongs_to :type
	belongs_to :category

	validates :date, :concept, :amount, presence: true
	validates :concept, length: {minimum: 5}

	def self.expenses_day(date,type=nil)
	  if type
	    Expense.where("date = ? AND type_id = ?",date, type).sum("amount")
	  else
	    Expense.where("date = ?",date).sum("amount")
	  end
	end

	def self.expenses_today
	  expenses_day(Date.today)
	end

	def self.expenses_yesterday
	  expenses_day(Date.today - 1)
	end

	def self.expenses_month(year,month,type=nil,category=nil,records=nil)
	  if month == 12
	    nextmonth = 1
	    nextyear = year + 1
	  else
	    nextmonth = month + 1
	    nextyear = year
	  end

	  inidate = Date.new(year,month,1)
	  findate = Date.new(nextyear,nextmonth,1) - 1 
	  
	  if !records
	    if type and category
	      Expense.where("date between ? AND ? AND type_id = ? AND category_id = ?", inidate, findate, type, category).sum("amount")
	    elsif type and !category
	      Expense.where("date between ? AND ? AND type_id = ?", inidate, findate, type).sum("amount")
	    elsif !type and category
	      Expense.where("date between ? AND ? AND category_id = ?", inidate, findate, category).sum("amount")        
	    else
	      Expense.where("date between ? AND ?", inidate, findate).sum("amount")
	    end
	  else
	    if type and category
	      Expense.where("date between ? AND ? AND type_id = ? AND category_id = ?", inidate, findate, type, category)
	    elsif type and !category
	      Expense.where("date between ? AND ? AND type_id = ?", inidate, findate, type)
	    elsif !type and category
	      Expense.where("date between ? AND ? AND category_id = ?", inidate, findate, category)
	    else
	      Expense.where("date between ? AND ?", inidate, findate)
	    end
	  end
	end

	def self.expenses_this_month
		hoy = Date.today
	  expenses_month(hoy.year,hoy.month)
	end

	def self.prev_month (year, month)
	  last_day_prev_month = Date.new(year,month,1) - 1
	  mes_ant = Array.new()
	  mes_ant.push(last_day_prev_month.year)
	  mes_ant.push(last_day_prev_month.month)
	  mes_ant
	end

	def self.expenses_prev_month
		hoy = Date.today
	  last_day_prev_month = Date.new(hoy.year,hoy.month,1) - 1
		arr = prev_month(hoy.year,hoy.month)
	  prev_year = arr[0]
	  prev_month = arr[1]
	  expenses_month(prev_year,prev_month)
	end

	# Totales por Tipo y Año/Mes (Últimos  6 meses)
	def self.totals_by_type_last_6months
	  expenses = Array.new()
	  mes01 = Array.new()
	  mes02 = Array.new()
	  mes03 = Array.new()
	  mes04 = Array.new()
	  mes05 = Array.new()
	  mes06 = Array.new()

	  hoy = Date.today
	  mes01=prev_month(hoy.year,hoy.month)
	  mes02=prev_month(mes01[0],mes01[1])
	  mes03=prev_month(mes02[0],mes02[1])
	  mes04=prev_month(mes03[0],mes03[1])
	  mes05=prev_month(mes04[0],mes04[1])
	  mes06=prev_month(mes05[0],mes05[1])
	  Type.all.each do |type|
	    arr_type = Array.new
	    arr_month = Array.new

	    amount01 = expenses_month(mes01[0],mes01[1],type)
	    arr_month.push(mes01[0],mes01[1],amount01)
	    arr_type.push(arr_month)
	    arr_month = Array.new

	    amount02 = expenses_month(mes02[0],mes02[1],type)
	    arr_month.push(mes02[0],mes02[1],amount02)
	    arr_type.push(arr_month)
	    arr_month = Array.new
	    
	    amount03 = expenses_month(mes03[0],mes03[1],type)
	    arr_month.push(mes03[0],mes03[1],amount03)
	    arr_type.push(arr_month)
	    arr_month = Array.new
	    
	    amount04 = expenses_month(mes04[0],mes04[1],type)
	    arr_month.push(mes04[0],mes04[1],amount04)
	    arr_type.push(arr_month)
	    arr_month = Array.new
	    
	    amount05 = expenses_month(mes05[0],mes05[1],type)
	    arr_month.push(mes05[0],mes05[1],amount05)
	    arr_type.push(arr_month)
	    arr_month = Array.new
	    
	    amount06 = expenses_month(mes06[0],mes06[1],type)
	    arr_month.push(mes06[0],mes06[1],amount06)
	    arr_type.push(arr_month)
	    
	    arr_temp = Array.new
	    arr_temp.push(type.typename,type.color,arr_type)

	    expenses.push(arr_temp)
	  end
	  expenses
	end

	# Totales por Fecha y Tipo (Mes actual)
	def self.totals_by_date_type
	  expenses = Array.new
	  hoy = Date.today
	  Type.all.each do |type|
	    arr_type = Array.new
	    arr_type.push(type.typename,type.color)
	    arr_days = Array.new
	    for i in 1..(hoy.day)
	      arr_1day = Array.new
	      fecha = Date.new(hoy.year,hoy.month,i)
	      amount = expenses_day(fecha,type.id)
	      arr_1day.push(i,amount)
	      arr_days.push(arr_1day)
	    end
	    arr_type.push(arr_days)
	    expenses.push(arr_type)
	  end
	  expenses  
	end

	def self.totals_by_category_current_month
	  expenses = Array.new
	  Category.all.each do |category|
	    arr_cat = Array.new
	    amount = expenses_month(Date.today.year,Date.today.month,nil,category)
	    arr_cat.push(category.catname,amount)
	    expenses.push(arr_cat)
	  end
	  expenses
	end

	def self.daily_amounts_current_previous_month
	  expenses = Array.new
	  hoy = Date.today
	  days_previous_month = (Date.new(hoy.year,hoy.month,1) -1).day
	  mesant = prev_month(hoy.year,hoy.month)
	  points_current_month = Array.new
	  amount = 0
	  for i in 1..(hoy.day)
	    amount = amount + expenses_day(Date.new(hoy.year,hoy.month,i))
	    temp = Array.new
	    temp.push(i,amount)
	    points_current_month.push(temp)
	  end
	  points_previous_month = Array.new
	  amount = 0
	  for i in 1..(days_previous_month)
	    amount = amount + expenses_day(Date.new(mesant[0],mesant[1],i))
	    temp = Array.new
	    temp.push(i,amount)
	    points_previous_month.push(temp)
	  end
	  expenses.push(points_previous_month,points_current_month)
	  expenses
	end
end
