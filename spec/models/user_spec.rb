require 'spec_helper'

describe User do
  
  before { @user = User.new(name: "Luis Martin Aguilar", email: "usuarioluis@prueba.com", password: "clavetieso", password_confirmation: "clavetieso") }

  subject { @user }
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should be_valid }

 	describe "cuando el nombre no esta presente" do
 		before { @user.name =" " }
 		it { should_not be_valid }
	end 
	describe "cuando el email no esta presente" do
	 		before { @user.email =" " }
	 		it { should_not be_valid }
	end 

	describe "cuando el nombre es muy largo" do
	 		before { @user.name = "a" * 51 }
	 		it { should_not be_valid }
	end 

	describe "cuando el formato de mail es invalido" do
	 		it " debe ser invalido" do
	 			direcciones=%w[user@prueba,com usuario_numero_.org usuario@prueba.comusuario@prueba.com usuario@prueba+prueba.com]
	 			direcciones.each do |direccion_invalida|
	 				@user.email = direccion_invalida
	 				expect(@user).not_to be_valid
	 			end
	 		end
	end 

	describe "cuando el formato de mail es valido" do
	 		it " debe ser valido" do
	 			direcciones=%w[user@prueba.COM A_US_ER@prueba.org.ec usuario.uno@prueba.ec]
	 			direcciones.each do |direccion_valida|
	 				@user.email = direccion_valida
	 				expect(@user).to be_valid
	 			end
	 		end
	end 

	describe "cuando el mailya existe" do
		before do
			usuario_con_el_mismo_mail = @user.dup
			usuario_con_el_mismo_mail.email = @user.email.upcase
			usuario_con_el_mismo_mail.save
			end
			it { should_not be_valid }

		end 

	describe "cuando el password no esta presente" do
		before do 
			@user = User.new(name:"Usuario Ejemplo", email: "usuario@prueba.com", password: " ", password_confirmation: " ")
		end
		it { should_not be_valid }
	end

	describe "cuando el password y la confirmacion no son iguales" do
		before { @user.password_confirmation = "missmatch" }
		it { should_not be_valid }
	end  

	describe "cuando el password es muy corto" do
		before { @user.password = @user.password_confirmation = "a"*5 }
		it { should_not be_valid }
	end 

	describe "devolver el valor de la autenticacion" do
		before { @user.save }
		let(:found_user) { User.find_by(email: @user.email) }

		describe "Con password valido" do
			it { should eq found_user.authenticate(@user.password) }
		end

		describe "con password invalido" do
			let(:user_for_invalid_password) { found_user.authenticate("invalid") }

			it { should_not eq user_for_invalid_password }
			specify { expect(user_for_invalid_password).to be_false }
		end
	end 
end

