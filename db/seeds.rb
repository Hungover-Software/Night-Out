# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.new(:email => "holla@me.com", :password => "HOLLA!", :password_confirmation => "HOLLA!", :preferred_name => "Lady Girl", :phone => "4028135296").save
User.new(:email => "cal@lol.com", :password => "lol.com", :password_confirmation => "lol.com", :preferred_name => "Cal", :phone => "4028135297").save
User.new(:email => "log@gmail.com", :password => "password", :password_confirmation => "password", :preferred_name => "Logan", :phone => "4021111111").save
User.new(:email => "cal@gmail.com", :password => "password", :password_confirmation => "password", :preferred_name => "Calae", :phone => "4022222222").save