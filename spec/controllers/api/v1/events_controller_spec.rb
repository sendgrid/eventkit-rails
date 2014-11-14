require 'rails_helper'
require 'spec_helper'

RSpec.describe Api::V1::EventsController, :type => :controller do

	before(:each) do
		@user = FactoryGirl.create(:user)
	end

	describe 'GET #index' do
		context "with no token" do
			it "receives an error" do
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
					expect(response).to be_success
					json = JSON.parse(response.body)
					expect(json).to include("events")
					expect(json["events"].length).to equal(10)
					expect(json["meta"]["total"]).to equal(10)
				end
			end

			context "with specific parameters given" do
				it "retrieves a list of events matching the parameters" do
					FactoryGirl.create_list(:event, 10)
					get :index, {token: @user.token, ip: "98.765.43.210"}
					expect(response).to be_success
					json = JSON.parse(response.body)
					expect(json).to include("events")
				end
			end
		end
	end

	describe 'POST #create' do
		context "with no token" do
			it "receives an error" do
				post :create, {
					:event => {
						:event => "delivered"
					}
				}
				json = JSON.parse(response.body)
				expect(json).to include("error")
			end
		end

		context "with a valid token" do
			it "creates a new event" do
				post :create, {
					:token => @user.token,
					:event => {
						:event => "delivered"
					}
				}
				expect(response).to be_success
				json = JSON.parse(response.body)
				expect(json).to include("event")
				expect(json["event"]["event"]).to include("delivered")
			end
		end
	end

	describe 'GET #show' do
		context "with no token" do
			it "receives an error" do
				get :show, {
					id: 1
				}
				json = JSON.parse(response.body)
				expect(json).to include("error")
			end
		end

		context "with a valid token" do
			it "retrieves the event with the given ID" do
				FactoryGirl.create_list(:event, 10)
				get :show, {
					:token => @user.token,
					:id => 1
				}
				expect(response).to be_success
				json = JSON.parse(response.body)
				expect(json).to include("event")
			end
		end
	end

	describe 'PUT #update' do
		context "with no token" do
			it "receives an error" do
				put :update, {
					id: 1,
					:event => {
						:email => "rspec@example.none"
					}
				}
				json = JSON.parse(response.body)
				expect(json).to include("error")
			end
		end

		context "with a valid token" do
			it "updates an event with the given ID" do
				FactoryGirl.create_list(:event, 10)
				put :update, {
					:token => @user.token,
					:id => 1,
					:event => {
						:email => "rspec@example.none"
					}
				}
				expect(response).to be_success
				json = JSON.parse(response.body)
				expect(json).to include("event")
				expect(json["event"]["email"]).to include("rspec@example.none")
			end
		end
	end

	describe 'DELETE #destroy' do
		context "with no token" do
			it "receives an error" do
				delete :destroy, {
					id: 1
				}
				json = JSON.parse(response.body)
				expect(json).to include("error")
			end
		end

		context "with a valid token" do
			it "deletes an event with the given ID" do
				FactoryGirl.create_list(:event, 10)
				delete :destroy, {
					:token => @user.token,
					:id => 1
				}
				expect(response).to be_success
				
				get :show, {
					:token => @user.token,
					:id => 1
				}
				expect(response).to have_http_status(404)
			end
		end
	end

end
