# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(:email => 'test@example.com', :password => 'password')
board = Board.create(:title => 'Board 1', :description => 'An example board', :created_by => user)

Lane.create([
  { :title => 'Backlog', :board => board },
  { :title => 'In Progress', :board => board },
  { :title => 'Done', :board => board }
])

Card.create([
  { :title => 'Card 1', :lane => Lane.find_by_title('Backlog') },
  { :title => 'Card 2', :lane => Lane.find_by_title('Backlog') },
  { :title => 'Card 3', :lane => Lane.find_by_title('Backlog') },
  { :title => 'Card 4', :lane => Lane.find_by_title('In Progress') },
  { :title => 'Card 5', :lane => Lane.find_by_title('In Progress') },
  { :title => 'Card 6', :lane => Lane.find_by_title('Done') }
])
