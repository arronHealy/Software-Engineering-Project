require 'rails_helper'

describe ArticlesController, type: 'controller' do
    describe '#creator' do
        context 'when specified article has a creator' do
            it 'should find articles with the same creator' do
                # create fake article to be found
                @article = double({title: 'News article', description: 'News of the day', creator: 'John Doe'})

                # create fake article list to returns same creator
                @articles = double({title: 'Sport article', description: 'Sport of the day', creator: 'John Doe'}, {title: 'Tech article', description: 'Tech News', creator: 'John Doe'})

                # stub Article find method and return fake article
                allow(Article).to receive(:find).and_return(@article)

                # stub Article model method and return fake articles
                allow(Article).to receive(:search_similar_creator).and_return(@articles)

                # stub empty? method on articles and return false
                allow(@articles).to receive(:empty?).and_return(false)

                # post request to search creators method
                post :search_creators, {:id => 7}
                
                # expect article controller variables to be assigned fake articles
                # expect flash message to be nil and that response renders search creators template
                expect(assigns(:article)).to eq(@article)
                expect(flash[:notice]).to eq(nil)
                expect(assigns(:articles)).to eq(@articles)
                expect(@response).to render_template :search_creators
            end
        end

        context 'when specified article has no creator' do
            it 'should redirect to articles page' do
                # create fake article with missing creator field
                @article = double({title: 'News article', description: 'News of the day', creator: ''})

                # stub Article find method and return fake article
                allow(Article).to receive(:find).and_return(@article)

                # post request to search creators method
                post :search_creators, {:id => 7}

                # expect article controller variable to be assigned with fake article
                # expect flash message to be assigned and response to redirect to articles path
                expect(assigns(:article)).to eq(@article)
                expect(flash[:notice]).to eq("'News article' has no creator info")
                expect(@response).to redirect_to articles_path
            end
        end

        context 'when specified creator has no other articles' do
            it 'should redirect to articles page' do
                # create fake article to be found
                @article = double({title: 'News article', description: 'News of the day', creator: 'John Doe'})

                # empty list of articles to show creator has not other articles
                @articles = []

                # stub Article find method and return fake article
                allow(Article).to receive(:find).and_return(@article)

                # stub Article model method and return an empty list
                allow(Article).to receive(:search_similar_creator).and_return(@articles)

                # stub articles empty? method and return true
                allow(@articles).to receive(:empty?).and_return(true)

                # send post request to search creators method
                post :search_creators, {:id => 7}
                
                # expect controller method variables to be assigned
                # expect flash message to be assigned and response to redirect to articles path
                expect(assigns(:article)).to eq(@article)
                expect(flash[:notice]).to eq("'John Doe' has no more articles")
                expect(assigns(:articles)).to eq([])
                expect(@response).to redirect_to articles_path
            end
        end
    end

    describe 'create articles controller method' do
        context 'when a new article is created' do
            it 'should redirect to the view article page' do
                # create fake article to be returned
                @article = double(title: 'Tech article', description: 'Tech news', creator: 'John Doe')

                # stub Article models new method and return the fake article
                allow(Article).to receive(:new).and_return(@article)

                # stub save method on article object and allow it to return true
                allow(@article).to receive(:save).and_return(true)

                # send post request to create controller method with article data
                post :create, :article => {:title => 'Tech article', :description => 'Tech news', :creator => 'John Doe'}

                # expect flash message to be set and response to redirect to article path
                expect(flash[:warning]).to eq("Article successfully saved.")
                expect(@response).to redirect_to article_path(@article)
            end
        end

        context 'when a new article is not created' do
            it 'should redirect to new article page' do
                # create fake article with missing fields
                @article = double(title: '', description: '', creator: 'John Doe')

                # stub Article models new method and return the fake article
                allow(Article).to receive(:new).and_return(@article)

                # stub article objects save method and allow it to return false
                allow(@article).to receive(:save).and_return(false)

                # send post request to controller create method with article data
                post :create, :article => {:title => '', :description => '', :creator => 'John Doe'}

                # expect flash message to be set and response to redirect to new article path
                expect(flash[:notice]).to eq("Error Article missing fields!")
                expect(@response).to redirect_to new_article_path
            end
        end
    end

    describe 'destroy articles controller method' do
        context 'when a article is deleted' do
            it 'should redirect to the articles path' do
                # create fake article to be destroyed
                @article = double(title: 'Tech article', description: 'Tech news', creator: 'John Doe')

                # stub Article models find method and allow it to return fake article
                allow(Article).to receive(:find).and_return(@article)

                # stub article objects destroy method 
                allow(@article).to receive(:destroy)

                # send post request to controller destroy method
                post :destroy, {:id => 3}

                # expect flash message to be set and response to redirect to articles path
                expect(flash[:warning]).to eq("Article '#{@article.title}' destroyed!")
                expect(@response).to redirect_to articles_path
            end
        end
    end

    describe 'edit articles controller method' do
        context 'when a article is updated' do
            it 'should redirect to view article page' do
                # create fake article to be updated
                @article = double(Article, id: 1, title: 'Tech article', description: 'Tech news', creator: 'John Doe', created_at: '30-April-2020', updated_at: '01-May-2020')

                # stub Article models find method and allow it to return fake article
                allow(Article).to receive(:find).and_return(@article)

                # stub article objects update method and allow it to return true
                allow(@article).to receive(:update).and_return(true)

                # send put request to update controller method with fake article data
                put :update, id: 1, :article => {:id => 1, :title => 'Tech article', :description => 'Tech news', :creator => 'John Doe', :created_at => '30-April-2020', :updated_at => '01-May-2020'}

                # expect flash message to be set and response to redirect to article path
                expect(flash[:warning]).to eq("Article was updated successfully!")
                expect(@response).to redirect_to article_path(@article)
            end
        end

        context 'when a article is not updated' do
            it 'should redirect to edit article page' do
                # create fake article to be returned with missing fields
                @article = double(Article, id: 1, title: '', description: '', creator: 'John Doe')

                # stub Article models find method and allow it to return fake article
                allow(Article).to receive(:find).and_return(@article)

                # stub update method on article object and allow it to return false
                allow(@article).to receive(:update).and_return(false)

                # send put request to update controller method with fake article data
                put :update, id: 1, :article => {:id => 1, :title => '', :description => '', :creator => 'John Doe', :created_at => '30-April-2020', :updated_at => '01-May-2020'}

                # expect flash message to be set and response to redirect to edit article path
                expect(flash[:notice]).to eq("Error Article not updated!")
                expect(@response).to redirect_to edit_article_path(@article)
            end
        end
    end
end