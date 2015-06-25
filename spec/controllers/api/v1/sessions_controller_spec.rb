require 'rails_helper'

RSpec.describe Api::V1::SessionsController, :type => :controller do
  let(:user) { FactoryGirl.create :user }

  describe "POST #create" do

    it "renders the user when credentials are correct" do
      post :create, session: { email: user.email, password: "12345678" }
      expect(json_response[:user]).to have_key(:auth_token)
    end

    it "renders an error message whne credentials are invalid" do
      post :create, session: { email: user.email, password: "qwerty" }
      expect(json_response[:session]).to have_key(:errors)
    end

    it "renders an error message when no email is sent" do
      post :create, session: { password: "qwerty" }
      expect(json_response[:session]).to have_key(:errors)
    end
  end

  describe "DELETE #destroy" do

    before(:each) do
      authorization_header(user.auth_token, user.email)
      delete :destroy
    end

    it { should respond_with 204 }
  end

end
