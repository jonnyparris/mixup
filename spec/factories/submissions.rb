FactoryGirl.define do
  factory :submission do
    association :circle, :future
    original
    remix

    trait :no_remix do
      original
      remix nil
    end

    factory :stem_submit, traits: [:no_remix]
  end
end
