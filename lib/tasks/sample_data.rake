namespace :db do
	desc "Fill database"
	task populate: :environment do
		admin = User.create!(login: "example", fullname: "Example User" , email: "example@test.org", password: "foobar", password_confirmation: "foobar")
		admin.toggle!(:admin)
		99.times do |n|
			login = "example-#{n+1}"
			fullname = Faker::Name.name
			email = "example-#{n+1}@test.org"
			password = "password"
			User.create!(login: login, fullname: fullname, email: email, password: password, password_confirmation: password)
		end

		users = User.all(limit: 6)
		50.times do
			content = Faker::Lorem.sentence(5)
			users.each {|user| user.microposts.create(content:content)}
		end
	end
end