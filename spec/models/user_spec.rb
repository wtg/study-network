require 'spec_helper'

describe "User" do

  before { @user = User.new(username: "testuser", real_name: "Test User", is_admin: 0, inactive: 0, email: "testu@rpi.edu") }
  subject { @user }

  it { should respond_to(:username) }
  it { should respond_to(:real_name) }
  it { should respond_to(:is_admin) }
  it { should respond_to(:inactive) }
  it { should respond_to(:email) }

  it { should be_valid }

  describe "when username is not present" do
    before { @user.username = "" } 
    it { should_not be_valid }
  end

  describe "when real_name is not present" do
    before { @user.real_name = ""} 
    it { should_not be_valid }
  end 

  describe "when admin status is not present" do
    before { @user.is_admin = nil }
    it { should_not be_valid }
  end

  describe "when inactive status is not present" do
    before { @user.inactive = nil }
    it { should_not be_valid }
  end

  describe "when email is not present" do 
    before { @user.email = "" }
    it { should_not be_valid }
  end

  describe "when year is not present" do
    before { @user.year = "" }
    it { should be_valid }
  end

  describe "when username already registered" do 
    before do 
      user_with_same_username = @user.dup
      user_with_same_username.username = @user.username.upcase
      user_with_same_username.save
    end
    it { should_not be_valid }
  end

end