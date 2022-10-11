require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: "Ashwin", credit_card: "1234567891234567", address: "517 Tartan circle", mobile: "9196373261", email: "aumasan@ncsu.edu", is_admin:"false",password_digest:"adsdasdad" )}

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  it "is not valid without a creditcard of length 16" do
    expect(subject.credit_card.length).to eq(16)
  end
  it "is not valid without a phone of 10 digits" do
    expect(subject.mobile.length).to eq(10)
  end

end
