FactoryGirl.define do
	factory :user do
		sequence(:fullname) { |n| "Person #{n}" }
		sequence(:email) { |n| "person#{n}@ex.com" }
		sequence(:login) { |n| "person#{n}" }
		password "foobar"
		password_confirmation "foobar"

		factory :admin do
			admin true
		end
	end

	factory :micropost do
		content "Lorem ipsum"
		user
	end
end