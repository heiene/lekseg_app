require 'spec_helper'

describe "Static pages" do 

 let(:base_title) { "This is a sample app" }

	describe "Home page" do 

		it "should have the content 'Sample app'" do
			visit '/static_pages/home'
			page.should have_selector('h1', :text => 'Sample App')
		end

		it "should have the content 'home'" do
			visit '/static_pages/home'
			page.should have_selector('title', :text => "#{base_title} | Home")
		end


	end


	describe "Help" do 

		it "should have the content Sample app" do
			visit '/static_pages/help'
			page.should have_selector('h1', :text => 'Sample App')
		end

		it "should have the title 'Help'" do
			visit '/static_pages/help'
			page.should have_selector('title', :text => "#{base_title} | Help")

		end


	end

	describe "About us" do 

		it "should have the content 'Sample app'" do
			visit '/static_pages/about'
			page.should have_selector('h1', :text => 'Sample App')
		end

		it "should have the content 'About us'" do
			visit '/static_pages/about'
			page.should have_selector('title', :text => "#{base_title} | About us")
		end


	end

	describe "Contact" do 

		it "should have the content 'Sample app'" do
			visit '/static_pages/contact'
			page.should have_selector('h1', :text => 'Contact')
		end

		it "should have the content 'Contact'" do
			visit '/static_pages/contact'
			page.should have_selector('title', :text => "#{base_title} | Contact")
		end


	end
end