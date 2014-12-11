require 'rails_helper'

RSpec.describe Api::V1::UsersController, :type => :controller do
	describe 'GET #index' do
		context "with no existing users in the database" do
			it "returns a success" do
				get :index
				expect(response).to be_success
			end
		end
		context "with some existing users in the database" do
			context "with no token" do
				it "receives an error" do
					FactoryGirl.create_list(:user, 10)
					get :index
					json = JSON.parse(response.body)
					expect(json).to include("error")
				end
			end

			context "with a valid token" do
				context "with no parameters given" do
					it "retrieves a list of all users" do
						FactoryGirl.create_list(:user, 10)
						get :index, token: "12345"
						expect(response).to be_success
						json = JSON.parse(response.body)
						expect(json).to include("users")
						expect(json["users"].length).to equal(10)
						expect(json["meta"]["total"]).to equal(10)
					end
				end

				context "with specific parameters given" do
					it "retrieves a list of users matching the parameters" do
						FactoryGirl.create_list(:user, 10)
						get :index, {token: "12345", username: "rspec1"}
						expect(response).to be_success
						json = JSON.parse(response.body)
						expect(json).to include("users")
					end
				end
			end
		end
	end

	describe 'POST #create' do
		context "with no existing users in the database" do
			it "creates a new user without a valid token" do
				post :create, {
					:user => {
						:username => "foobar"
					}
				}
				expect(response).to be_success
			end
		end
		context "with some existing users in the database" do
			context "with no token" do
				it "receives an error" do
					FactoryGirl.create_list(:user, 10)
					post :create, {
						:user => {
							:username => "foobar"
						}
					}
					json = JSON.parse(response.body)
					expect(json).to include("error")
				end
			end

			context "with a valid token" do
				it "creates a new user" do
					FactoryGirl.create_list(:user, 10)
					post :create, {
						:token => "12345",
						:user => {
							:username => "foobar"
						}
					}
					expect(response).to be_success
					json = JSON.parse(response.body)
					expect(json).to include("user")
					expect(json["user"]["username"]).to include("foobar")
				end
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
			it "retrieves the user with the given ID" do
				FactoryGirl.create_list(:user, 10)
				get :show, {
					:token => "12345",
					:id => 1
				}
				expect(response).to be_success
				json = JSON.parse(response.body)
				expect(json).to include("user")
			end
		end
	end

	describe 'PUT #update' do
		context "with no token" do
			it "receives an error" do
				put :update, {
					id: 1,
					:user => {
						:username => "rspec@example.none"
					}
				}
				json = JSON.parse(response.body)
				expect(json).to include("error")
			end
		end

		context "with a valid token" do
			it "updates an user with the given ID" do
				FactoryGirl.create_list(:user, 10)
				put :update, {
					:token => "12345",
					:id => 1,
					:user => {
						:username => "rspec@example.none"
					}
				}
				expect(response).to be_success
				json = JSON.parse(response.body)
				expect(json).to include("user")
				expect(json["user"]["username"]).to include("rspec@example.none")
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
			it "deletes an user with the given ID" do
				FactoryGirl.create_list(:user, 10)
				delete :destroy, {
					:token => "12345",
					:id => 1
				}
				expect(response).to be_success

				get :show, {
					:token => "12345",
					:id => 1
				}
				expect(response).to have_http_status(404)
			end
		end
	end

end
