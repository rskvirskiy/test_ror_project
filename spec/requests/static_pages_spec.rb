require 'spec_helper'

describe "StaticPages" do
  subject { page }


	describe "About Page" do

	    before {visit about_path}

		it { should have_selector('h1', text: 'This is the test Ruby on Rails app') }

	    it { should have_selector('title', text: full_title('About')) }
	end	

end
