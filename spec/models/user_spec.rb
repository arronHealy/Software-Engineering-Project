require 'rails_helper'

describe User do
    describe "registered user with email" do
        it "should find a user by their email" do
            # create a user
            User.create(email: 'test@mail.com', password: 'password')

            # query user model method with email
            @user = User.find_user('test@mail.com')

            # expect results to include created articles 
            expect(@user).not_to eq(nil)
            expect(@user.email).to eq('test@mail.com')
        end

        it "should not find a user with no registered email" do
            # create list of users
            @users = [User.create(email: 'test@mail.com', password: 'password'), User.create(email: 'test2@mail.com', password: 'password')]

            # query User model method with email
            @user = User.find_user('test3@mail.com')

            # expect user to equal nil
            expect(@user).to eq(nil)
        end
    end
end