namespace :db do
	desc "Fill database"
	task populate: :environment do
		User.create!(login: "example", fullname: "Example User" , email: "example@test.org", password: "foobar", password_confirmation: "foobar")
		99.times do |n|
			login = "example-#{n+1}"
			fullname = Faker::Name.name
			email = "example-#{n+1}@test.org"
			password = "password"
			User.create!(login: login, fullname: fullname, email: email, password: password, password_confirmation: password)
		end
	end
end