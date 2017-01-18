require 'rails_helper'

RSpec.describe "organizations/show", type: :view do
  before(:each) do
    @organization = assign(:organization, Organization.create!(
      :name => "Name",
      :description => "MyText",
      :phone => "Phone",
      :email => "Email",
      :website => "Website"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Website/)
  end
end
