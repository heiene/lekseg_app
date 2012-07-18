require 'spec_helper'

describe "Static pages" do 

	subject { page }
	
	shared_examples_for "all_static_pages" do
		it { should have_selector('h1',    text: heading) }
	    it { should have_selector('title', text: full_title(page_title)) }
  	end


  	it "should have clickable links" do
  		visit root_path
  		# let(:heading) {'Sign up'}
  		click_link "Sign up now!"
  		should have_selector('h1', text: 'Sign up now!')
  		# it_should_behave_like "all_static_pages"
	end
	
	describe "Home page" do 
		before { visit root_path }
		let(:heading) { 'Home' }
		let(:page_title) { '' }

		it_should_behave_like "all_static_pages"
		it { should_not have_selector('title', text: "Home") }
			
	end

	describe "Help" do 

		before { visit help_path}
		let(:heading) { 'Help' }
		let(:page_title) { 'Help' }

		it_should_behave_like "all_static_pages"
		
	end

	describe "About us" do 

		before { visit about_path}
		let(:heading) { 'About us' }
		let(:page_title) { 'About us' }

		it_should_behave_like "all_static_pages"

	end

	describe "Contact" do 
		
		before { visit contact_path}
		let(:heading) { 'Contact' }
		let(:page_title) { 'Contact' }

		it_should_behave_like "all_static_pages"
	end
end