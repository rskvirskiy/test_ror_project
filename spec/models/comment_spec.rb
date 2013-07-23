require 'spec_helper'

describe Comment do

	let(:micropost) { FactoryGirl.create(:micropost) }
	before do
		@micropost = micropost.comments.build(content: "sgsgsdg")
	end

	subject { @comment }

	it { should respond_to(:content) }
	it { should respond_to(:micropost_id) }
	it { should respond_to(:micropost) }
	its (:micropost) { should == micropost }

	it { should be_valid }

	describe "when micropost_id is not present" do
		before { @comment.micropost_id = nil }
		it { should_not be_valid }
	end

	describe "accesibility attributes" do
		it "should not allow access to micropost_id" do
			expect do
				comment.new(micropost_id: micropost.id)
			end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end

	describe "when micropost_id not present" do
		before { @comment.micropost_id = nil }
		it { should_not be_valid }
	end

	describe "with blank content" do
		before { @comment.content = " " }
		it { should_not be_valid }
	end

	describe "with content what too long" do
		before { @comment.content = "a" * 141 }
		it { should_not be_valid }
	end

end
