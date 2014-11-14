require 'permissions'

FactoryGirl.define do
    factory :user do
        permissions         Permissions::VIEW | Permissions::EDIT
        token               "12345"
        username            "rspec"
    end
end