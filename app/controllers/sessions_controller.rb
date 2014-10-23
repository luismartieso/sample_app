class SessionsController < ApplicationController
	def new
	end

	def create 
		user=User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			#Ingresa al usuario y lo redirecciona a la pagina del mismo
		else
			flash[:error] = 'Combinacion email/password invalida'
			render 'new'
		end
	end

	def destroy
	end
end
