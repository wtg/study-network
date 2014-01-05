require 'spec_helper'

describe "User Pages" do 

  subject { page }
  let(:user) { FactoryGirl.create(:user) }

  describe "profile page" do
    before { visit user_path(user) }

    it { should have_content(user.username) }
    it { should have_content(user.real_name) }
    it { should have_content(user.email) }
    it { should have_content(user.year) }
  end

  describe "edit account details" do
    before { visit edit_user_path(user) }

    describe "with invalid information" do 
      before do
        fill_in "user_real_name", with: " " 
        fill_in "user_email", with: " "
        select("Junior", from: "user_year")
      end

      it "should not update user information" do
        click_button "Save User"
        page.should have_content('Editing')
      end
    end

    describe "with valid information" do
      before do 
        fill_in "user_real_name", with: "Test User"
        fill_in "user_email", with: "testuser@rpi.edu"
        select("Junior", from: "user_year")
      end

      it "should update user information" do
        click_button "Save User"
        page.should_not have_content('Editing')
      end
    end

  end

end
