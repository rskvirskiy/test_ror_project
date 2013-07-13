RSpec.configure do |c|
	c.before(:each,type: :feature) do
		Capybara::Screenshot.autosave_on_failure = example.metadata[.screenshot]
	end
end