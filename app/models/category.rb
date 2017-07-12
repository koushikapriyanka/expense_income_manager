class Category < ApplicationRecord
	has_many :income_expense_category_mappings
	has_many :incomes, through: :income_expense_category_mappings, source: :categorized, :source_type => 'Income'
	has_many :expenses, through: :income_expense_category_mappings, source: :categorized, :source_type => 'Expense'
	validates :name, uniqueness: true
end
