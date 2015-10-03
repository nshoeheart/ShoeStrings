class User < ActiveRecord::Base
    VALID_USERNAME_REGEX = /\A[A-Za-z]+(?:[_\-\.0-9][A-Za-z0-9]+)*\z/
    validates :username, presence: true, length: {maximum: 50}, format: {with: VALID_USERNAME_REGEX}, uniqueness: {case_sensitive: false}

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
    before_save {self.email = email.downcase}

    has_secure_password
    validates :password, presence: true, length: {minimum: 6}
end
