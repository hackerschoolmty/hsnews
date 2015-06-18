require 'rails_helper'

RSpec.describe Api::V1::LinksController, :type => :controller do

  describe "GET #index" do

    context "when the search param is NOT present" do
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

    context "when the search param is present" do
      before(:each) do
        FactoryGirl.create :link, title: "New iphone 1"
        FactoryGirl.create :link, title: "new iphone 2"
        FactoryGirl.create :link, title: "new iphone 3"
        FactoryGirl.create :link, title: "Apple Tv"

        get :index, search: "iphone"
      end

      it "returns 3 records" do
        links_response = JSON.parse(response.body, symbolize_names: true)
        expect(links_response[:links]).to have(3).items
      end
    end

  end

  describe "GET #show" do

    before(:each) do
      @link = FactoryGirl.create :link
      get :show, id: @link.id
    end

    it "returns a single record" do
      link_response = JSON.parse(response.body, symbolize_names: true)
      expect(link_response[:link][:id]).to eq(@link.id)
    end

  end
end
