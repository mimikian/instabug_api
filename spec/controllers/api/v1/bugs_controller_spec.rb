require 'rails_helper'
require 'spec_helper'

describe Api::V1::BugsController do
  before(:each) do 
    request.headers['Accept'] = "v1"
  end

  describe "GET #show" do
    before(:each) do
      @bug = FactoryGirl.create :bug
      request.headers["Application-Token"] = "LeNU-ImvJLOLCxu5cwrrFg"
      get :show, id: @bug.number, format: :json
    end

    # it "returns the information about a reporter on a hash" do
    #   bug_response = JSON.parse(response.body, symbolize_names: true)
    #   expect(bug_response[:number]).to eql @bug.number
    # end

    it { should respond_with 200 }
  end

  describe "POST #create" do

    context "when is successfully created" do
      before(:each) do
        @bug_attributes = FactoryGirl.attributes_for :bug
        request.headers["Application-Token"] = "LeNU-ImvJLOLCxu5cwrrFg"
        request.headers["Content-Type"] = "application/json"
        post :create, { bug: @bug_attributes }
      end

      it "renders the json representation for the bug record just created" do
        sleep 5.seconds
        bug_response = JSON.parse(response.body, symbolize_names: true)
        expect(bug_response[:number]).to eql @bug_attributes[:number]
      end
      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        @invalid_bug_attributes = {application_token: "", status: "", priority: ""}
        request.headers["Content-Type"] = "application/json"
        post :create, { bug: @invalid_bug_attributes },
          format: :json
      end

      it "renders an errors json" do
        bug_response = JSON.parse(response.body, symbolize_names: true)
        expect(bug_response).to have_key(:errors)
      end

      it "renders the json errors on why the bug could not be created" do
        bug_response = JSON.parse(response.body, symbolize_names: true)
        expect(bug_response[:errors][:application_token]).to include "can't be blank"
        expect(bug_response[:errors][:status]).to include "can't be blank"
        expect(bug_response[:errors][:priority]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end


end
