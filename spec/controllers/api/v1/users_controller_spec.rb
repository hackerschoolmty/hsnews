require 'rails_helper'

RSpec.describe Api::V1::UsersController, :type => :controller do

  describe "#POST create" do

    context "when is success" do
      before(:each) do
        post :create, user: FactoryGirl.attributes_for(:user)
      end

      it "renders a user record" do
        expect(json_response[:user]).to have_key(:email)
      end

      it { should respond_with 201 }
    end

    context "when is not success" do
      before(:each) do
        post :create, user: {email: "bademail"}
      end

      it "renders a user record" do
        expect(json_response[:user]).to have_key(:errors)
      end

      it { should respond_with 422 }
    end
  end

end
