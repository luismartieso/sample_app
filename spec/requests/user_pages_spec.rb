require 'spec_helper'

describe "UserPages" do
  
  subject { page }

  describe "Pagina de Perfil" do
  	let(:user) { FactoryGirl.create(:user) }
  	before { visit user_path(user) }

  	it { should have_content(user.name) }
  	it { should have_title(user.name) }
  end 

  describe "Pagina de registro" do
  	before { visit registro_path }

  	it { should have_content('Registro') }
  	it { should have_title(full_title('Registro')) }
  end

  describe "registro" do
  	before { visit registro_path }
  	let(:submit) { "Crear mi Cuenta"}

  	describe "con informacion  invalida" do
  		it "no debe crear el usuario" do
  			expect { click_button submit }.not_to change(User, :count)
  		end
  	end

  	describe "con informacion valida" do
  		before do
  			fill_in "Name", with: "Usuario Ejemplo"
  			fill_in "Email", with: "user@ejemplo.com"
  			fill_in "Password", with: "clavetieso"
  			fill_in "Confirmation", with: "clavetieso"
  		end
  		it "Debe crear el usuario" do
  			expect { click_button submit }.to change(User, :count).by(1)
  		end
  	end

  end
end
