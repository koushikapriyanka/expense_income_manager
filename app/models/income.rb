class Income < ApplicationRecord
	belongs_to :user
	has_one :income_expense_category_mapping, as: :categorized
	has_one :category, :through => :income_expense_category_mapping, as: :categorized
	validates :amount, numericality: {greater_than: 0 }, presence: true
	accepts_nested_attributes_for :category
	
	def category_attributes=(category_attributes)
		self.category = Category.find_or_create_by(:name => category_attributes[:name])
	end

end
