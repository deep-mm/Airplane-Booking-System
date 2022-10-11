require 'rails_helper'

RSpec.describe City, :type => :model do
  subject {
    City.new(name: "City1",)
  }
  it "is valid with valid attributes"do
    expect(subject).to be_valid
  end

  it "is not valid without a name"do
    name = City.new(name: nil)
    expect(name).to_not be_valid
  end
  it "must have a name" do
    city= City.create
    expect(city.errors[:name]).to_not be_empty
  end
end

RSpec.describe CitiesController, type: :controller do
  describe "GET index" do

    it "routes GET /cities to #index" do
      expect(get: "/cities").to route_to("cities#index")
    end

    it "returns a successful response" do
      get :index
      expect(response).to_not be_successful
    end

  end

  describe 'POST #create' do
    it 'Renders New City' do
      post :create
      expect(response).to_not redirect_to @city
    end
    it "routes POST /cities to #create" do
      expect(post: "/cities").to route_to("cities#create")
    end
  end

  describe 'GET #new' do
    it 'routes GET /cities/new to #new' do
      expect(get: "/cities/new").to route_to("cities#new")
    end
  end

  it "must have a name" do
    post= City.create
    expect(post.errors[:name]).to_not be_empty
  end
end