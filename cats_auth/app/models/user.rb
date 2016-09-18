class User < ActiveRecord::Base
  validates :user_name, :password_digest, :session_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 8, allow_nil: true }
  after_initialize :ensure_session_token

  has_many :cats,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Cat

  has_many :rental_requests,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :CatRentalRequest



  attr_reader :password
  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    self.save
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end

  def self.find_by_credentials(user_name, password)
    @user = User.find_by(user_name: user_name)
    return nil if @user.nil?
    @user.is_password?(password) ? @user : nil
  end

end
