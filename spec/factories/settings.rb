FactoryGirl.define do
    factory :setting do
        name            { |n| "setting#{n}"}
        value           { |n| "value#{n}"}
        visible         0
    end
end