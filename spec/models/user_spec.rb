require 'rails_helper'

RSpec.describe User, :type => :model do

  describe "#generate_authentication_token!" do
    before(:each) do
      @user = FactoryGirl.build :user
    end

    it "generates a unique token" do
      allow(SecureRandom).to receive(:base64).and_return("auniquetoken")
      expect{ @user.generate_authentication_token! }.to change{@user.auth_token}.from(nil).to("auniquetoken")
    end

    it "avoids nil on the auth token" do
      @user.generate_authentication_token!
      expect(@user.auth_token).to_not be_nil
    end

  end
end
