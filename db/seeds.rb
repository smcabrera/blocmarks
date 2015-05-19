require 'faker'

#I'm the admin
me = User.new(
  :name     => "Stephen", # One's own name is easier to remember
  :email    => "stephen.m.cabrera@gmail.com", # One's own email is easier to remember
  :password => "password", # Easy to remember password
)

me.skip_confirmation! # Necessary becuase we're using the devise confirmable module
me.save

5.times do
  user = User.new(
    :name => Faker::Name.name,
    :email => Faker::Internet.email,
    :password => Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save
end
users = User.all

5.times do
  Topic.create(
    :name => Faker::Lorem.sentence(2, false, 0),
    :user_id => users.sample.id
  )
end
topics = Topic.all

25.times do
  Bookmark.create(
    :url => Faker::Internet.url,
    :name => Faker::Lorem.sentence(2, false, 0),
    :user_id => users.sample.id,
    :topic_id => topics.sample.id
  )
end


puts "Seed finished"
puts "#{users.count} users created"
puts "#{topics.count} topics created"
puts "#{Bookmark.count} bookmarks created"


