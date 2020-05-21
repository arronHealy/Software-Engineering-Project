class ArticlesController < ApplicationController

    def article_params
        # permitted article information to be expected, created_at and updated_at on model tracked by rails
        params.require(:article).permit(:title, :description, :creator)
    end

    def index
        # check for sort param passed in request data
        sort = params[:sort] || session[:sort]

        # if sort not set query all articles and return
        if sort.equal?(nil)
            @articles = Article.all and return
        end

        # check sort variable and return articles list ordered by date
        case sort
        when 'new'
        @articles = Article.order(updated_at: :desc)
        when 'old'
        @articles = Article.order(updated_at: :asc)
        end

    end

    def search_creators
        # find article by id passed in request
        @article = Article.find(params[:id])

        # if creator field blank redirect and return from method 
        if @article.creator.blank?
            flash[:notice] = "'#{@article.title}' has no creator info"
            redirect_to articles_path and return
        end
        
        # if creator field set search for articles by same creator omitting the current article
        @articles = Article.search_similar_creator(@article.creator, @article.title)

        # if creator has no other articles then redirect and return 
        if @articles.empty?
            flash[:notice] = "'#{@article.creator}' has no more articles"
            redirect_to articles_path and return
        end
    end

    def show
        @article = Article.find(params[:id])
    end

    def new
    end

    def home
    end

    def create
        # create new article with params sent in request
        @article = Article.new(article_params)

        # if article is valid then save and redirect to article view path
        if @article.save
            flash[:warning] = "Article successfully saved."
            redirect_to article_path(@article)
        else
            # if article is missing fields then redirect and show error message
            flash[:notice] = "Error Article missing fields!"
            redirect_to '/articles/new'
        end
    end

    def edit
        @article = Article.find(params[:id])
    end

    def update
        # find article to be updated by id passed in request
        @article = Article.find(params[:id])
        
        # if article is valid then update article and redirect to view article path
        if @article.update(article_params)
            flash[:warning] = "Article was updated successfully!"
            redirect_to article_path(@article)
        else
            # if article has missing fields then show error message and redirect to edit path
            flash[:notice] = "Error Article not updated!"
            redirect_to edit_article_path(@article)
        end
    end

    def destroy
        # find article to be destroyed
        @article = Article.find(params[:id])
        # destroy article
        @article.destroy
        # set flash message and redirect to articles path
        flash[:warning] = "Article '#{@article.title}' destroyed!"
        redirect_to articles_path
    end

end