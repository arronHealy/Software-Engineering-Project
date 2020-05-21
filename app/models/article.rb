class Article < ActiveRecord::Base
    # validate that article has title and description before saving in db
    validates :title, presence: true, length: { minimum: 6, maximum: 30 }
    validates :description, presence: true, length: { minimum: 6, maximum: 100 }

    def self.search_similar_creator(creator, title)
        Article.where("creator = (?) AND title != (?)", creator, title)
    end
end