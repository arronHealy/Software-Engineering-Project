class User < ActiveRecord::Base
    # convert email to downcase before saving in db
    before_save {self.email = email.downcase}

    # email regex
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    # email validation
    validates :email, presence: true, 
                      uniqueness: { case_sensitive: false }, 
                      length: {maximum: 100},
                      format: {with: VALID_EMAIL_REGEX}

    # this line tells rails that model has password to be hashed by bcrypt
    has_secure_password

    # user model method to find user by email
    def self.find_user(email)
       User.find_by(email: email)
    end
    
end