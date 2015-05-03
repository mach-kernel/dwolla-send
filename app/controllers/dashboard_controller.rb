require 'dwolla'

class DashboardController < ApplicationController

	# Generally, it is best to handle errors in every function for every case,
	# however, given that this is a toy application and we will only throw API errors,
	# it is ok to do this.
	rescue_from Dwolla::DwollaError, :with => :rescue_dwolla_errors

	def rescue_dwolla_errors(exception)
		reset_session if exception.message == "Expired access token." or exception.message == "Invalid access token."

		if exception.message != "Expired access token." or exception.message != "Invalid access token."
			flash[:error] = "Uh oh! A Dwolla API error was encountered: \n#{exception.message}"
			redirect_to :back
		else
			flash[:error] = "An authentication error was encountered and you were logged out. Try again?"
			redirect_to '/'
		end
	end

	def is_email?(str)
		str =~ /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	end

	def step1
		if not_configured?
			render 'notconf'
		else
			fs = DwollaVars.Dwolla::FundingSources.get
			@fsjson = "```js \n #{JSON.pretty_generate fs}\n```"
			@fs = []
			fs.each do |h|
				@fs.push([h['Name'], h['Id']]) 
			end
		end
	end

	def send_money
		if params[:commit] == "Send Money"

			# Set other necessities
			params[:payment][:pin] = DwollaVars.pin
			params[:payment][:destinationType] = is_email?(params[:payment][:destinationId]) ? "Email" : "Dwolla"

			@txjson = "```js \n #{JSON.pretty_generate DwollaVars.Dwolla::Transactions.get DwollaVars.Dwolla::Transactions.send params[:payment]}\n```"

			render 'step2'
		else
			flash[:error] = "Something went wrong. Try again?"
			redirect_to '/'
		end
	end

end