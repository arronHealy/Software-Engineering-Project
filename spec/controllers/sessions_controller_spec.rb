require 'rails_helper'

describe SessionsController, type: 'controller' do
    
    describe 'Logging in a user' do
        context 'when a user log in is successful' do
            it 'should redirect to the user profile' do
                # set session variable before as not available in test without cookie
                session = {user_id: 1}

                # create fake user
                @user = double({id: 1, email: 'test@mail.com', password: 'password'})

                # stub User model method and return fake user
                allow(User).to receive(:find_user).and_return(@user)

                # stub user object authenticate method and return true
                allow(@user).to receive(:authenticate).and_return(true)

                # send post request to create controller method with user data
                post :create, :user => {:id => 1, :email => 'test@mail.com', :password => 'password'}

                # expect user controller variables to be assigned fake user
                # expect session id to equal user id and that response redirects to user path
                expect(assigns(:user)).to eq(@user)
                expect(session[:user_id]).to eq(@user.id)
                expect(flash[:warning]).to eq("Logged in successfully!")
                expect(@response).to redirect_to user_path(@user)
            end
        end

        context 'when a user log in is unsuccessful' do
            it 'should redirect to the login path' do
                # set session variable before as not available in test without cookie
                session = {user_id: nil}

               # create fake user
                @user = double({id: nil, email: '', password: ''})

                # stub User model method and return nil
                allow(User).to receive(:find_user).and_return(nil)

                # stub user object method and return nil
                allow(@user).to receive(:nil?).and_return(nil)

                # stub user object authenticate method and return false
                allow(@user).to receive(:authenticate).and_return(false)

                # send post request to create controller method with user data
                post :create, :user => {:id => nil, :email => '', :password => ''}

                # expect user controller variables to be assigned fake user
                # expect session id to equal user id and that response redirects to user path
                expect(assigns(:user)).to eq(nil)
                expect(session[:user_id]).to eq(nil)
                expect(flash[:notice]).to eq("Error! Unsuccessful Login. Please try again!")
                expect(@response).to redirect_to login_path
            end
        end
    end

    describe 'Logging out a user' do
        context 'when a user logs out' do
            it 'should redirect to the root path' do
                # set session variable before as not available in test without cookie
                session = {user_id: nil}
                
                # post to destroy method on controller
                post :destroy

                # expect session user_id to be assigned nil and flash message set
                # expect response to redirect to the root path 
                expect(session[:user_id]).to eq(nil)
                expect(flash[:warning]).to eq("You are now Logged out!")
                expect(@response).to redirect_to root_path
            end
        end
    end

end