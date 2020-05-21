# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
articles = [{:title => 'test title1', :description => 'testing description1', :creator => 'Arron Healy', :created_at => '10-March-2018', :updated_at => '26-March-2018'},
    	  {:title => 'test title2', :description => 'testing description2', :creator => 'John Doe', :created_at => '20-March-2019', :updated_at => '30-April-2019'},
    	  {:title => 'test title3', :description => 'testing description3', :creator => 'Jane Doe', :created_at => '30-May-2019', :updated_at => '11-June-2019'},
          {:title => 'test title4', :description => 'testing description4', :creator => 'Mick Mac', :created_at => '20-March-2020', :updated_at => '30-April-2020'},
          {:title => 'test title5', :description => 'testing description5', :creator => 'John Doe', :created_at => '20-March-2016', :updated_at => '30-April-2017'},
          {:title => 'test title6', :description => 'testing description6', :created_at => '20-March-2016', :updated_at => '30-May-2016'},
       ]
       
users = [{:email => 'john@mail.com', :password => 'password123', :created_at => '30-April-2020', :updated_at => '01-May-2020'},
    	  {:email => 'arron@mail.com', :password => 'password456', :created_at => '01-May-2020', :updated_at => '02-May-2020'},
  	 ]

articles.each do |article|
  Article.create!(article)
end

users.each do |user|
  User.create!(user)
end
