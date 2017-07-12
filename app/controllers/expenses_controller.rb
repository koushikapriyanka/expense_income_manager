class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  def index
    @expenses = current_user.expenses.includes(:category)
    respond_to do |format|
      format.html
      format.pdf do
        pdf = WickedPdf.new.pdf_from_string(ExpensesController.new.render_to_string(:action => "/expenses_report", :layout => false, locals: {expenses_data: @expenses }))
        send_data(pdf, :filename => "expenses_report.pdf")
      end
      format.csv do
         results = CSV.generate do |csv|
            csv << ["Category","Amount","Date"]
            @expenses.each{|expense|
              csv << [expense.category.try(:name),expense.amount,expense.created_at.to_date ]
            }            
        end
        send_data(results, :filename => "expenses_report.csv")
      end
    end  
  end

  def show
  end

  def new
    @expense = Expense.new
  end

  def edit
  end

  def create
    @expense = Expense.new(expense_params)

    respond_to do |format|
      if @expense.save
        format.html { redirect_to @expense, notice: 'Expense was successfully created.' }
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to @expense, notice: 'Expense was successfully updated.' }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to expenses_url, notice: 'Expense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_expense
      @expense = Expense.find_by(:id => params[:id], :user_id => current_user.id)
    raise ActiveRecord::RecordNotFound if @expense.blank?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expense_params
      params[:expense][:user_id] =  current_user.id
      params.require(:expense).permit(:amount,:user_id, :category_attributes => [:name])
    end
end
