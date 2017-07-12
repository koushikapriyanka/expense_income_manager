require 'test_helper'

class IncomeExpenseCategoryMappingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @income_expense_category_mapping = income_expense_category_mappings(:one)
  end

  test "should get index" do
    get income_expense_category_mappings_url
    assert_response :success
  end

  test "should get new" do
    get new_income_expense_category_mapping_url
    assert_response :success
  end

  test "should create income_expense_category_mapping" do
    assert_difference('IncomeExpenseCategoryMapping.count') do
      post income_expense_category_mappings_url, params: { income_expense_category_mapping: { category_id: @income_expense_category_mapping.category_id } }
    end

    assert_redirected_to income_expense_category_mapping_url(IncomeExpenseCategoryMapping.last)
  end

  test "should show income_expense_category_mapping" do
    get income_expense_category_mapping_url(@income_expense_category_mapping)
    assert_response :success
  end

  test "should get edit" do
    get edit_income_expense_category_mapping_url(@income_expense_category_mapping)
    assert_response :success
  end

  test "should update income_expense_category_mapping" do
    patch income_expense_category_mapping_url(@income_expense_category_mapping), params: { income_expense_category_mapping: { category_id: @income_expense_category_mapping.category_id } }
    assert_redirected_to income_expense_category_mapping_url(@income_expense_category_mapping)
  end

  test "should destroy income_expense_category_mapping" do
    assert_difference('IncomeExpenseCategoryMapping.count', -1) do
      delete income_expense_category_mapping_url(@income_expense_category_mapping)
    end

    assert_redirected_to income_expense_category_mappings_url
  end
end
