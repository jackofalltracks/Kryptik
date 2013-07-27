require 'spec_helper'

describe "statuses/show" do
  before(:each) do
    @status = assign(:status, stub_model(Status,
      :user_id => 1,
      :content => "MyText",
      :index => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/MyText/)
    rendered.should match(//)
  end
end
