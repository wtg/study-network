require 'spec_helper'

describe 'Course' do 

  before { @course = Course.new(title: 'Operating Systems', crn: '55404', abrev_name: 'CSCI', level: '4210') }
  subject { @course }

  it { should respond_to(:title) }
  it { should respond_to(:crn) }
  it { should respond_to(:abrev_name) }
  it { should respond_to(:level) }

  it { should be_valid }

  describe "when title is not present" do 
    before { @course.title = "" }
    it { should_not be_valid }
  end

  describe "when crn is not present" do
    before { @course.crn = "" }
    it { should_not be_valid }
  end
  
  describe "when abrev_name is not present" do
    before { @course.abrev_name = "" } 
    it { should_not be_valid }
  end

  describe "when level is not present" do
    before { @course.level = "" }
    it { should_not be_valid }
  end

  describe "when course already exists" do 
    before do 
      duplicate_course = @course.dup
      duplicate_course.title = @course.title.upcase
      duplicate_course.save
    end
    it { should_not be_valid}
  end

end