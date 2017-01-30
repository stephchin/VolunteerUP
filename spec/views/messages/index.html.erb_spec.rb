require 'rails_helper'

RSpec.describe "messages/index", type: :view do
  before(:each) do
    assign(:messages, [
      Message.create!(
        :body => "Body"
      ),
      Message.create!(
        :body => "Body"
      )
    ])
  end

  it "renders a list of messages" do
    render
    assert_select "tr>td", :text => "Body".to_s, :count => 2
  end
end
