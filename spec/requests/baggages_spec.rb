require 'rails_helper'

RSpec.describe "Baggages", type: :request do
  describe "GET /baggages" do
    it "works! (now write some real specs)" do
      get baggages_path
      expect(response).to have_http_status(200)
    end
  end
end
