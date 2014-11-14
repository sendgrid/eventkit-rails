require 'rails_helper'
require 'spec_helper'

RSpec.describe Api::V1::EventsController, :type => :controller do

	before(:each) do
		@user = FactoryGirl.create(:user)
	end

	describe 'GET #index' do
		context "with no token" do
			it "receives an error" do
				FactoryGirl.create_list(:event, 10)
				get :index
				json = JSON.parse(response.body)
				expect(json).to include("error")
			end
		end

		context "with a valid token" do
			context "with no parameters given" do
				it "retrieves a list of all events" do
					FactoryGirl.create_list(:event, 10)
					get :index, token: @user.token
					json = JSON.parse(response.body)
					expect(json).to include("events")
					expect(json["events"].length).to equal(10)
					expect(json["meta"]["total"]).to equal(10)
				end
			end
		end
	end

end
