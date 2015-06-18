require 'rails_helper'

RSpec.describe Link, :type => :model do
  describe "class methods" do

    describe ".search" do

      context "when no params are present" do
        it "returns all records" do
          expect(Link.search).to have(Link.count).items
        end
      end

      context "when params are present" do
        it "returns 3 records when params equals 'new iphone'" do
          FactoryGirl.create :link, title: "New iphone 1"
          FactoryGirl.create :link, title: "new iphone 2"
          FactoryGirl.create :link, title: "new iphone 3"
          FactoryGirl.create :link, title: "Apple Tv"

          expect(Link.search('new iphone')).to have(3).items
        end
      end

    end
  end
end
