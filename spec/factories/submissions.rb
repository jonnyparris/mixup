FactoryGirl.define do
  factory :submission do
    circle
    original
    remix

    trait :no_remix do
      remix nil
    end

    factory :stem_submit, traits: [:no_remix]
  end
end
