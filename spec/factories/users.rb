require 'permissions'

FactoryGirl.define do
    factory :user do
        permissions         Permissions::VIEW | Permissions::EDIT | Permissions::POST
        token               "12345"
        username            { |n| "rspec#{n}"}
    end
end