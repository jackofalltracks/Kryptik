# require 'spec_helper'

# describe User do 
  
#   it "has a valid factory" do
#     FactoryGirl.create(:user).should be_valid
#   end
  
#   it "is invalid without an email address" do
#     FactoryGirl.build(:user, email: nil).should_not be_valid
#   end
  
#   it "is invalid without a password" do
#     FactoryGirl.build(:user, password: nil).should_not be_valid
#   end
  
#   it "creates a new studio with a new user" do
#     FactoryGirl.create(:user).studios.count.should eq 1
#   end

# end

require 'spec_helper'

describe User do
  before(:each) do
    @user = FactoryGirl.build(:user)
    # @user2 = FactoryGirl.build(:user)
  end

  it { should allow_mass_assignment_of(:email) }
  it { should allow_value("bigballscaptain@testicles.me").for(:email) }
  it { should_not allow_value("big_balls_captain").for(:email) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }
  it { should respond_to(:confirmation_token) }
  # it { should respond_to(:profile_name) }
  # it { should have_one(:account) }

 
  it "has a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end

  it "should create a new instance given valid attributes" do
    user = User.create( email: "mrsmiley@gmail.com" )
    user.password = "DirtyBoyz1984"  
    user.should be_valid
  end
  
  it "is invalid without an email address" do
    FactoryGirl.build(:user, email: nil).should_not be_valid
  end
  
  it "is invalid without a password" do
    FactoryGirl.build(:user, password: nil).should_not be_valid
  end

  it "should be an instance of User Model" do
    expect(@user).to be_an_instance_of(User)
  end

  it "should be only one User at this FactoryGirl test" do
    expect(User.count) === 1
  end

  it "should reject passwords that are too long" do
    long_password = "a" * 51
    long_password_user = User.create( email: "mrsmiley@gmail.com" )
    long_password_user.password = long_password
    long_password_user.should_not be_valid
  end

  it "should reject passwords that are too short" do
    short_password = "a" * 1
    short_password_user = User.new( email: "mrsmiley@gmail.com" )
    short_password_user.password = short_password
    short_password_user.should_not be_valid
  end

 #  it "should have a first and last name" do
 #   expect(@user.full_name).to eq(@user.first_name + @user.last_name
 #    )
 #  end

end

