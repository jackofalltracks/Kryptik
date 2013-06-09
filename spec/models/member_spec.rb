require 'spec_helper'

describe Member do
  before(:each) do
    @member = FactoryGirl.build(:member)
    # @user2 = FactoryGirl.build(:user)
  end

  it { should respond_to(:user_id) }
  it { should respond_to(:band_id) }
  it { should belong_to(:user) }
  it { should belong_to(:band) }
  it { should respond_to(:position) }	

	# it "should tell us if the User is a member of a specific Band" do
	#   Band.create!(
	#   name: "Balls Deep", 
	#   position: "Second Puncher", 
	#   bio: "Hello!")
	#   expect(@user.member_of? "Balls Deep").to eq("Balls Deep") 
	#   expect(@user.member_of? "BaLlS dEEp").to eq("Balls Deep") 
	#   expect(@user.member_of? "Billy Bob").to eq(false) 
	# end

end
