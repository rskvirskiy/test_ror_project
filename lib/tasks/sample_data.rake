namespace :db do
	desc "Fill database"
	task populate: :environment do
		make_users
		make_microposts
		make_comments
		make_relationships
	end
end

def make_users
	admin = User.create!(login: "example", fullname: "Example User" , email: "example@test.org", password: "foobar", password_confirmation: "foobar")
		admin.toggle!(:admin)
		99.times do |n|
			login = "example-#{n+1}"
			fullname = Faker::Name.name
			email = "example-#{n+1}@test.org"
			password = "password"
			User.create!(login: login, fullname: fullname, email: email, password: password, password_confirmation: password)
		end
end

def make_microposts
	users = User.all(limit: 6)
		50.times do
			content = Faker::Lorem.sentence(5)
			users.each {|user| user.microposts.create(content:content)}
		end
end

def make_comments
	microposts = Micropost.all(limit: 30)
	microposts.each do |micropost|
		4.times do
			content = Faker::Lorem.sentence(5)
			micropost.comments.create(content: content)
		end
	end
end

def make_relationships
	users = User.all
	user = users.first
	followed_users = users[2..48]
	followers = users[3..40]
	followed_users.each {|followed| user.follow!(followed)}
	followers.each {|follower| follower.follow!(user)}
end