require 'spec_helper'

describe "Pages" do
  
  describe "Home Page" do 
    it "should have  the content 'Rensselaer Study Network'" do 
      visit '/'
      expect(page).to have_content('Rensselaer Study Network')
    end
  end


end
