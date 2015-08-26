require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  describe "POST create" do
    let!(:user){ create(:user) }
    let!(:event){ create(:event) }

    it "should be Unauthorized" do
      post :create, { event_id: event.id, comment: {"body" => "Some body" }, format: :json }
      expect(response.status).to eql(401)
      expect(response.message).to eql("Unauthorized")
    end

    it "should create event and return json event" do
      sign_in(user)
      post :create, { event_id: event.id, comment: {"body" => "Some body" }, format: :json }
      expect(Comment.all.size).to eql(1)
      expect(Comment.first.body).to eql("Some body")
      expect(JSON.parse(response.body).is_a?(Hash)).to eql(true)
      expect(JSON.parse(response.body).keys).to contain_exactly("id", "body", "user_id", "event_id", "created_at", 
        "updated_at", "user")
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
