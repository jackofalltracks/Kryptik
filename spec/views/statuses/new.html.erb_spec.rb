require 'spec_helper'

describe "statuses/new" do
  before(:each) do
    assign(:status, stub_model(Status,
      :user_id => 1,
      :content => "MyText",
      :index => ""
    ).as_new_record)
  end

  it "renders new status form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", statuses_path, "post" do
      assert_select "input#status_user_id[name=?]", "status[user_id]"
      assert_select "textarea#status_content[name=?]", "status[content]"
      assert_select "input#status_index[name=?]", "status[index]"
    end
  end
end
