require 'rails_helper'
begin
  UsersController
rescue
  UsersController = nil
end


RSpec.describe UsersController, type: :controller do

  let(:full_user) { User.create(
    username: "brucewillis",
    password_digest: BCrypt::Password.create("yippie-kai-ae"),
    session_token: SecureRandom.urlsafe_base64(16)
    )}

  let(:password) { "yippie-kai-ae" }

  describe "GET #new" do
    it "renders the new links page" do
      get :new , link: {}
      expect(response).to render_template("new")
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "renders the new user template" do
        post :create, user: { username: nil, password: nil }
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end
    end

    context "with valid params" do
      it "redirects to the root directory" do
        post :create, user: { username: full_user.username, password: "falsepassword" }
        expect(response).to redirect_to(new_user_url)
      end
    end
  end
end
