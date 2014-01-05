require 'spec_helper'

describe "Pages" do

  subject { page } 
  
  describe "Home Page" do 
    before { visit root_path }
    it { should have_content('Rensselaer Study Network') }
  end


end
