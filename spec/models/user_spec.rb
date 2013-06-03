require 'spec_helper'

describe User do
  before(:each) do
    @user = FactoryGirl.build(:user)
    # @user2 = FactoryGirl.build(:user)
  end

  context 'when user is a Fan' do

    it "add_role Fan method should work" do
      @user.add_role :fan
      @user.has_role?(:fan).should be_true
      @user.has_role?(:admin).should_not be_true
    end
  
  end

  context 'when user is an Artist' do
    
    it "add_role Artist method should work" do
      @user.add_role :artist
      @user.has_role?(:artist).should be_true
      @user.has_role?(:admin).should_not be_true
    end

    it "should tell us if the User is a member of a specific Band" do
      Band.create!(
      name: "Balls Deep", 
      user_id: 1, 
      position: "Second Puncher", 
      bio: "Hello!")
      expect(@user.member_of? "Balls Deep").to eq("Balls Deep") 
      expect(@user.member_of? "BaLlS dEEp").to eq("Balls Deep") 
      expect(@user.member_of? "Billy Bob").to eq(false) 
    end
  
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
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:full_name) }
  it { should respond_to(:city) }
  it { should respond_to(:state) }
  it { should respond_to(:country) }
  it { should respond_to(:zipcode) }
  it { should respond_to(:sex) }

  # Associations
  it { should have_many(:bands) }

  it "should be able to choose relevent gender" do
    @user.sex = "Male"
    expect(@user.sex).to eq("Male")
    expect(@user.sex).to_not eq("Cat")

    @user.sex = "Female"
    expect(@user.sex).to eq("Female")
    expect(@user.sex).to_not eq("Cat")

    @user.sex = "Transgender"
    expect(@user.sex).to eq("Transgender")
    expect(@user.sex).to_not eq("Cat")
  end

  it "should have a full name that is first & last added together" do
    expect(@user.full_name).to eq(@user.first_name + @user.last_name)
  end

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


end

