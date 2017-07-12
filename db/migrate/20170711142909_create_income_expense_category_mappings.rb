class CreateIncomeExpenseCategoryMappings < ActiveRecord::Migration[5.0]
  def change
    create_table :income_expense_category_mappings do |t|
      t.belongs_to :category
      t.references :categorized, polymorphic: true, index: {:name => "categorized_idx"}
    end
  end
end
