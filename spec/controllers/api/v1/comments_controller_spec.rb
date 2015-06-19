require 'rails_helper'

RSpec.describe Api::V1::CommentsController, :type => :controller do
  let(:link) { FactoryGirl.create :link }

  describe "GET #index" do
    before(:each) do
      4.times { FactoryGirl.create :comment, link: link }
      4.times { FactoryGirl.create :comment }
      get :index, link_id: link.id
    end

    it "renders a comments array" do
      expect(json_response[:comments]).to have(4).items
    end
  end

end
