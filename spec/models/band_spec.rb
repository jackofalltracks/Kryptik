require 'spec_helper'

describe Band do
	
	before(:each) do
		@band = FactoryGirl.build(:band)
	end

	it { should allow_mass_assignment_of(:name) }
	it { should respond_to(:name) }	
	it { should respond_to(:position) }	

	# Associations
	it { should belong_to(:user) }

	it "has a valid factory" do
		FactoryGirl.create(:band).should be_valid
	end

	it "should create a new instance given valid attributes" do
		band = Band.create( name: "Cracker Kitchen" )
		band.should be_valid
	end

	it "is invalid without a name" do
	    FactoryGirl.build(:band, name: nil).should_not be_valid
	end

	it "should be an instance of Band Model" do
		expect(@band).to be_an_instance_of(Band)
		expect(@band).to_not be_an_instance_of(Band)
	end

	it "should be only one Band at this FactoryGirl test" do
		expect(Band.count) === 1
	end

	it "should have a position that is an type of String" do
		expect(@band.position).class === String
		expect(@band.position).class != Fixnum
  	end

end