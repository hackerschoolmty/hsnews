FactoryGirl.define do
  factory :comment do
    content { FFaker::HipsterIpsum.paragraph }
    link
  end
end
