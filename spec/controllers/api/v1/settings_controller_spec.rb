require 'rails_helper'

RSpec.describe Api::V1::SettingsController, :type => :controller do

	before(:each) do
		@user = FactoryGirl.create(:user)
	end

	describe 'GET #index' do
		context "with no parameters given" do
			it "retrieves a list of all settings" do
				FactoryGirl.create_list(:setting, 10)
				get :index
				expect(response).to be_success
				json = JSON.parse(response.body)
				expect(json).to include("settings")
				expect(json["meta"]["total"]).to equal(json["settings"].length)
			end
		end

		context "with specific parameters given" do
			it "retrieves a list of settings matching the parameters" do
				FactoryGirl.create_list(:setting, 10)
				get :index, name: "setting1"
				expect(response).to be_success
				json = JSON.parse(response.body)
				expect(json).to include("settings")
			end
		end
	end

	describe 'POST #create' do
		it "creates a new setting" do
			post :create, {
				:setting => {
					:name => "is_testing",
					:value => "true"
				}
			}
			expect(response).to be_success
			json = JSON.parse(response.body)
			expect(json).to include("setting")
			expect(json["setting"]["name"]).to include("is_testing")
			expect(json["setting"]["value"]).to include("true")
		end
	end

	describe 'GET #show' do
		it "retrieves the setting with the given ID" do
			FactoryGirl.create_list(:setting, 10)
			get :show, {
				:id => 1
			}
			expect(response).to be_success
			json = JSON.parse(response.body)
			expect(json).to include("setting")
		end
	end

	describe 'PUT #update' do
		context "with no token" do
			it "receives an error" do
				put :update, {
					id: 1,
					:setting => {
						:name => "foo",
						:value => "bar"
					}
				}
				json = JSON.parse(response.body)
				expect(json).to include("error")
			end
		end

		context "with a valid token" do
			it "updates a setting with the given ID" do
				FactoryGirl.create_list(:setting, 10)
				put :update, {
					:token => @user.token,
					:id => 1,
					:setting => {
						:name => "foo",
						:value => "bar"
					}
				}
				expect(response).to be_success
				json = JSON.parse(response.body)
				expect(json).to include("setting")
				expect(json["setting"]["name"]).to include("foo")
				expect(json["setting"]["value"]).to include("bar")
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
			it "deletes a setting with the given ID" do
				FactoryGirl.create_list(:setting, 10)
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
