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

  describe "POST #create" do

    context "when the record is valid" do
      before(:each) do
        post :create, link_id: link.id,
          comment: { content: FFaker::HipsterIpsum.paragraph }
      end

      it "renders a comment resource created by the server" do
        expect(json_response[:comment]).to have_key(:id)
      end

      it { should respond_with 201 }
    end

    context "when the record is not valid" do
      before(:each) do
        post :create, link_id: link.id,
                      comment: { content: "" }
      end

      it "renders the errors from the server" do
        expect(json_response[:comment]).to have_key(:errors)
      end

      it { should respond_with 422 }
    end
  end

end
