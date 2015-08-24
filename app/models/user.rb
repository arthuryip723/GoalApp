class User < ActiveRecord::Base
  attr_reader :password

  validates :username, :session_token, :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true}

  after_initialize :ensure_session_token

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)

    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def ensure_session_token
    self.session_token ||= User.generate_unique_token
  end

  def self.generate_unique_token
    begin
      token = SecureRandom::urlsafe_base64(16)
    end until !User.find_by_session_token(token)
    token
  end

  def reset_session_token
    self.session_token = User.generate_unique_token
    self.save!
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
end
