require 'spec_helper'

describe "Authentication" do
	subject { page }
	describe "Pagina de Ingreso" do
		before { visit ingreso_path }

		it { should have_content('Ingreso') }
		it { should have_title('Ingreso') }
		end
	
	describe "ingreso" do
		before { visit ingreso_path}

		describe "Con informacion invalida" do
			before { click_button "Ingreso"}

			it { should have_title('Ingreso') }
			it { should have_selector('div.alert.alert-error') }
	end

	describe "con informacion valida" do 
		let(:user) { FactoryGirl.create(:user) }
			before do
				fill_in "Email", with: user.email.upcase
				fill_in "Password", with: user.password
				click_button "Ingreso"
			end 

			it { should have_title(user.name) }
			it { should have_link('Perfil', href: user_path(user)) }
			it { should have_link('Salida', href: salida_path) }
			it { should_not have_link('Ingreso', href: ingreso_path) }
	end
  end
end
