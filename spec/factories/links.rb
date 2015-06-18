FactoryGirl.define do
  factory :link do
    title { FFaker::HipsterIpsum.words }
    url { FFaker::Internet.http_url }
  end

end
