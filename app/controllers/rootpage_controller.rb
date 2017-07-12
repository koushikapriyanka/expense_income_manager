class RootpageController < ApplicationController
	require 'csv'
	include RootpageHelper

	def get_bank_details
		bank_details = bank_statment_details(current_user.id)
	    respond_to do |format|
	      format.csv do
	         results = CSV.generate do |csv|
	            csv << ["Category", "Amount", "Type", "Date"]
	            bank_details.each{|detail|
	              csv << [detail['category_name'], detail['amount'],detail['type'],detail['created_at'].to_date ]
	            }            
	        end
	        send_data(results, :filename => "income_report.csv")
	      end
	    end    
	end
end
