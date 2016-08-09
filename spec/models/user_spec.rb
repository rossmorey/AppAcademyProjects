require 'rails_helper'

begin
  User
rescue
  User = nil
end

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe "associations" do
    it { should have_many(:goals)}
  end

  describe "class methods" do

    let(:empty_user) { User.create(
      username: nil,
      password_digest: nil,
      session_token: nil
      )}

    let(:full_user) { User.create(
      username: "brucewillis",
      password_digest: BCrypt::Password.create("yippie-kai-ae"),
      session_token: SecureRandom.urlsafe_base64(16)
      )}

    let(:password) { "yippie-kai-ae" }

    describe "User#password=" do
      it "sets @password" do
        empty_user.password=(password)

        expect(empty_user.password).to eq(password)
      end

      it "sets self.password_digest" do
        before = empty_user.password_digest
        empty_user.password=(password)

        expect(empty_user.password_digest).to_not eq(before)
      end
    end

    describe "User#is_password?" do
      it "validates correct password" do
        password_check = full_user.is_password?(password)

        expect(password_check).to be true
      end

      it "does not validate incorrect password" do
        password_check = full_user.is_password?("falsepassword")

        expect(password_check).to be false
      end
    end

    describe "User#reset_token!" do
      it "changes session token after call" do
        before = full_user.session_token
        full_user.reset_token!

        expect(full_user.session_token).to_not be(before)
      end
    end

    describe "User::validate_user(username, password)" do
      it "returns user when correct credentials are inputted" do
        user_check = User.validate_user(full_user.username, password)

        expect(user_check).to eq(full_user)
      end

      it "returns nil when INcorrect credentials are inputted" do
        user = User.validate_user(full_user.username, "falsepassword")

        expect(user).to be_nil
      end
    end

    describe "User#ensure_session_token" do
      it "sets session_token when it is nil" do
        empty_user.ensure_session_token

        expect(empty_user.session_token).to_not be_nil
      end

      it "doesn't override existing session_token" do
        before = full_user.session_token
        full_user.ensure_session_token

        expect(full_user.session_token).to eq(before)
      end
    end
  end

end
