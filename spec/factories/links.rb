FactoryGirl.define do
  factory :link do
    title { FFaker::HipsterIpsum.words.join(" ") }
    url { FFaker::Internet.http_url }
    user
  end

end
