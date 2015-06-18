require 'rails_helper'

RSpec.describe Api::V1::LinksController, :type => :controller do

  describe "GET #index" do

    before(:each) do
      4.times { FactoryGirl.create(:link) }
      get :index
    end

    it "returns 4 records" do
      links_response = JSON.parse(response.body, symbolize_names: true)
      expect(links_response[:links]).to have(4).items
    end

    it "responds with a 200 code" do
      expect(response.response_code).to be 200
    end

    it "responds with json" do
      expect(response.content_type).to eq(Mime::JSON)
    end

  end

end
