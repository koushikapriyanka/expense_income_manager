module RootpageHelper

	def bank_statment_details(user_id)
		income_details = Income.joins(:category).where(:user_id=>user_id).select("incomes.*, categories.name as category_name").as_json
		income_details.map{|x| x["type"] = "INCOME"}
		expense_details = Expense.joins(:category).where(:user_id=>user_id).select("expenses.*, categories.name as category_name").as_json
		expense_details.map{|x| x["type"] = "EXPENSE"}
		return (income_details + expense_details).sort_by{|x| x['created_at']}
	end
end
