require 'rails_helper'

describe UsersController, type: 'controller' do

    describe 'create user controller method' do
        context 'when a new user is created' do
            it 'should redirect to the view article page' do
                # create fake user to be returned
                @user = double(email: 'test@mail.com', password: 'password')

                # stub User models new method and return the fake user
                allow(User).to receive(:new).and_return(@user)

                # stub save method on user object and allow it to return true
                allow(@user).to receive(:save).and_return(true)

                # send post request to create controller method with user data
                post :create, :user => {:email => 'test@mail.com', :password => 'password'}

                # expect flash message to be set and response to redirect to login path
                expect(flash[:warning]).to eq("You have Successfully Signed up. Please Login to access Wiki-Blog")
                expect(@response).to redirect_to login_path
            end
        end

        context 'when a new user is not created' do
            it 'should redirect to the sign up page' do
                # create fake user with missing fields
                @user = double(email: '', password: '')

                # stub User models new method and return the fake user
                allow(User).to receive(:new).and_return(@user)

                # stub user objects save method and allow it to return false
                allow(@user).to receive(:save).and_return(false)

                # send post request to controller create method with user data
                post :create, :user => {:email => '', :password => ''}

                # expect flash message to be set and response to redirect to sign up path
                expect(flash[:notice]).to eq("Sign up failed! You have entered invalid credentials.")
                expect(@response).to redirect_to signup_path
            end
        end
    end

    describe 'edit user controller method' do
        context 'when a user is updated' do
            it 'should redirect to view user page' do
                # create fake user to be updated
                @user = double(User, id: 1, email: 'test@mail.com', password: 'password')

                # stub User models find method and allow it to return fake user
                allow(User).to receive(:find).and_return(@user)

                # stub user objects update method and allow it to return true
                allow(@user).to receive(:update).and_return(true)

                # send put request to update controller method with fake user data
                put :update, id: 1, :user => {:id => 1, :email => 'test1@mail.com', :password => ''}

                # expect flash message to be set and response to redirect to user path
                expect(flash[:warning]).to eq("Account info successfully updated.")
                expect(@response).to redirect_to user_path(@user)
            end
        end

        context 'when a user is not updated' do
            it 'should redirect to edit user page' do
                # create fake user to be returned with missing fields
                @user = double(User, id: 1, email: '', password: '')

                # stub User models find method and allow it to return fake user
                allow(User).to receive(:find).and_return(@user)

                # stub update method on user object and allow it to return false
                allow(@user).to receive(:update).and_return(false)

                # send put request to update controller method with fake user data
                put :update, id: 1, :user => {:id => 1, :email => '', :password => ''}

                # expect flash message to be set and response to redirect to edit user path
                expect(flash[:notice]).to eq("Update failed! You have entered invalid credentials.")
                expect(@response).to redirect_to edit_user_path(@user)
            end
        end
    end
end