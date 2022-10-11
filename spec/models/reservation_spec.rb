require 'rails_helper'

RSpec.describe Reservation, type: :model do
  subject { Reservation.new(passengers: "1", reservation_class: "economy", amenities: "none", cost: "100", flight_id: "ABCD", user_id:"1",confirmation_number:"ABCD" )}

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  # it "is not valid without a iteger passenger" do
  #   expect((subject.passengers).match?(/\A-?\d+\Z/)).to eq(true)
  # end
  it "is not valid without a rservation class" do
    subject.reservation_class=nil
    expect(subject).to_not be_valid
  end
  it "is not valid without an amenitiy" do
    subject.amenities=nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a cost" do
    subject.cost=nil
    expect(subject).to_not be_valid
  end

end
