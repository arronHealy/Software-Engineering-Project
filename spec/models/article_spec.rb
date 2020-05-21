require 'rails_helper'

describe Article do
    describe "#articles with similar creator" do
        it "should find articles by the same creator" do
            # create list of articles with same creator
            @articles = [Article.create(title: 'News Article', description: 'News of the day', creator: 'John Doe'), Article.create(title: 'Sport Article', description: 'Sports of the day', creator: 'John Doe')]

            # query Article model method with creator name
            @results = Article.search_similar_creator('John Doe', 'Test Article')

            # expect results to include created articles
            # * refers to splatting the array to access article data 
            expect(@results).to include(*@articles)
        end

        it "should not find articles by different creators" do
            # create list of articles with same creator
            @articles = [Article.create(title: 'News Article', description: 'News of the day', creator: 'John Doe'), Article.create(title: 'Sport Article', description: 'Sports of the day', creator: 'John Doe')]

            # create list of articles with different creators
            @other_articles = [Article.create(title: 'Coding Article', description: 'News about coding', creator: 'Jim Bean'), Article.create(title: 'Food Article', description: 'Food recipe', creator: 'Jack Daniel')]

            # query Article model method with creator name
            @results = Article.search_similar_creator('John Doe', 'Test Article')

            # expect results to include articles with same creator
            # expect result to not include articles by different creators
            # * refers to splatting array to access article data in array
            expect(@results).to include(*@articles)
            expect(@results).not_to include(*@other_articles)
        end
    end
end