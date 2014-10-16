require 'spec_helper'

describe "UserPages" do
  
  subject { page }

  describe "Pagina de registro" do
  	before { visit registro_path }

  	it { should have_content('Registro') }
  	it { should have_title(full_title('Registro')) }
  end
end
