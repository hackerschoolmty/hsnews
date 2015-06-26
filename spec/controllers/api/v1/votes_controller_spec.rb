require 'rails_helper'

RSpec.describe Api::V1::VotesController, :type => :controller do
  let(:link) { FactoryGirl.create :link }
  let(:user) { FactoryGirl.create :user }

  describe "POST #create" do

    context "when the user is not logged in" do
      before(:each) do
        post :create, link_id: link.id
      end

      it { should respond_with 401 }
    end

    context "when the user is logged in" do
      before(:each) do
        authorization_header(user.auth_token, user.email)
      end

      context "when is success" do
        before(:each) do
          post :create, link_id: link.id, vote: { like: true }
        end

        it "renders the vote" do
          expect(json_response[:vote]).to have_key(:id)
        end

        it { should respond_with 201 }
      end

      context 'when is not success' do
        before(:each) do
          post :create, link_id: link.id, vote: { like: nil }
        end

        it "renders errors if link not saved" do
          expect(json_response[:vote]).to have_key(:errors)
        end

        it { should respond_with 422 }
      end
    end
  end

end
