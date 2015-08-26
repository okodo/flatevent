require 'rails_helper'

RSpec.describe EventsController, type: :controller do

  describe "GET index" do
    let!(:user){ create(:user) }
    let!(:event){ create(:event) }
    let!(:event1){ create(:event, user: user) }

    it "should be Unauthorized" do
      get :index, format: :json
      expect(response.status).to eql(401)
      expect(response.message).to eql("Unauthorized")
    end

    it "should return json of my events" do
      sign_in(user)
      get :index, { format: :json }
      expect(response.status).to eql(200)
      expect(JSON.parse(response.body).is_a?(Array)).to eql(true)
      expect(JSON.parse(response.body).size).to eql(1)
      expect(JSON.parse(response.body).first["id"]).to eql(event1.id)
      expect(JSON.parse(response.body).first.keys).to contain_exactly("id", "title", "starts_at", "recurs_on", "user_id",
        "created_at", "updated_at", "user", "comments", "startsAt", "type", "editable", "deletable", "draggable", "incrementsBadgeTotal", "recurs_on_text")
    end

    it "should return json of my events" do
      sign_in(user)
      get :index, { all: "1", format: :json }
      expect(response.status).to eql(200)
      expect(JSON.parse(response.body).is_a?(Array)).to eql(true)
      expect(JSON.parse(response.body).size).to eql(2)
      expect(JSON.parse(response.body).first.keys).to contain_exactly("id", "title", "starts_at", "recurs_on", "user_id",
        "created_at", "updated_at", "user", "comments", "startsAt", "type", "editable", "deletable", "draggable", "incrementsBadgeTotal", "recurs_on_text")
      expect(JSON.parse(response.body).first["user"].keys).to contain_exactly("id", "fullname", "email", "created_at", "updated_at")

    end

  end

  describe "GET show" do
    let!(:user){ create(:user) }
    let!(:event){ create(:event) }
    it "should be Unauthorized" do
      get :show, { id: event.id, format: :json }
      expect(response.status).to eql(401)
      expect(response.message).to eql("Unauthorized")
    end

    it "should return json of event" do
      sign_in(user)
      get :show, { id: event.id, format: :json}
      expect(response.status).to eql(200)
      expect(JSON.parse(response.body).is_a?(Hash)).to eql(true)
      expect(JSON.parse(response.body).keys).to contain_exactly("id", "title", "starts_at", "recurs_on", "user_id",
        "created_at", "updated_at", "user", "comments", "startsAt", "type", "editable", "deletable", "draggable", "incrementsBadgeTotal", "recurs_on_text")
      expect(JSON.parse(response.body)["user"].keys).to contain_exactly("id", "fullname", "email", "created_at", "updated_at")
    end
  end

  describe "POST create" do
    let!(:user){ create(:user) }

    it "should be Unauthorized" do
      post :create, { event: {"title" => "Some title", "starts_at" => "12.12.2015", "recurs_on" => "month" }, format: :json }
      expect(response.status).to eql(401)
      expect(response.message).to eql("Unauthorized")
    end

    it "should create event and return json event" do
      sign_in(user)
      post :create, { event: {"title" => "Some title", "starts_at" => "12.12.2015", "recurs_on" => "month" }, format: :json }
      expect(Event.all.size).to eql(1)
      expect(Event.first.title).to eql("Some title")
      expect(JSON.parse(response.body).is_a?(Hash)).to eql(true)
      expect(JSON.parse(response.body).keys).to contain_exactly("id", "title", "starts_at", "recurs_on", "user_id",
        "created_at", "updated_at", "user", "comments", "startsAt", "type", "editable", "deletable", "draggable", "incrementsBadgeTotal", "recurs_on_text")
      expect(JSON.parse(response.body)["user"].keys).to contain_exactly("id", "fullname", "email", "created_at", "updated_at")
    end

  end
end

def sign_in(user = double('user'))
  if user.nil?
    allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
    allow(controller).to receive(:current_user).and_return(nil)
  else
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
  end
end
