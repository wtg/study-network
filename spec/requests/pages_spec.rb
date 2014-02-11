require 'spec_helper'

describe "Pages" do

  subject { page } 
  
  describe "Home Page When Logged Out" do 
    before { visit root_path }
    it { should have_content('Rensselaer Study Network') }
    it { should have_content('Sign In')}
  end

end
