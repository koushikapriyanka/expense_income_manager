class IncomesController < ApplicationController
  before_action :set_income, only: [:show, :edit, :update, :destroy]

  def index
    require 'csv'
    @incomes = current_user.incomes.includes(:category)
    respond_to do |format|
      format.html
      format.pdf do
        pdf = WickedPdf.new.pdf_from_string(IncomesController.new.render_to_string(:action => "/income_report", :layout => false, locals: {income_data: @incomes }))
        send_data(pdf, :filename => "income_report.pdf")
      end
      format.csv do
         results = CSV.generate do |csv|
            csv << ["Category","Amount","Date"]
            @incomes.each{|income|
              csv << [income.category.try(:name),income.amount,income.created_at.to_date ]
            }            
        end
        send_data(results, :filename => "income_report.csv")
      end
    end    
  end

  def show
  end

  def new
    @income = Income.new
  end

  def edit
  end

  def create
    @income = Income.new(income_params)

    respond_to do |format|
      if @income.save
        format.html { redirect_to @income, notice: 'Income was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @income.update(income_params)
        format.html { redirect_to @income, notice: 'Income was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @income.destroy
    respond_to do |format|
      format.html { redirect_to incomes_url, notice: 'Income was successfully destroyed.' }
    end
  end

  private
    def set_income
      @income = Income.find_by(:id => params[:id], :user_id => current_user.id)
    raise ActiveRecord::RecordNotFound if @income.blank?
    end

    def income_params
      params[:income][:user_id] =  current_user.id
      params.require(:income).permit(:amount,:user_id, :category_attributes => [:name])
    end
end
