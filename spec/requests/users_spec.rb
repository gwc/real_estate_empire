require 'spec_helper'

describe "Users" do
  describe "signup" do
    describe "failure" do
      it "should not make a new user" do
        lambda do 
          visit signup_path
          fill_in "Name",         :with => ""
          fill_in "Email",        :with => ""
          fill_in "Password",     :with => ""
          fill_in "Confirmation", :with => ""
          click_button "Sign up"
          response.should render_template('users/new')
          response.should have_selector('div#error_explanation')
        end.should_not change(User, :count)
      end
    end
    describe "success" do
      it "should make a new user" do
         lambda do 
            visit signup_path
            fill_in "Name",         :with => "Example User"
            fill_in "Email",        :with => "user@example.com"
            fill_in "Password",     :with => "foobar"
            fill_in "Confirmation", :with => "foobar"
            click_button "Sign up"
            response.should have_selector('div.flash.success', :content => "Welcome to the Real Estate Empire Application!")
            response.should render_template('users/show')
          end.should change(User, :count).by(1)
      end
    end 
  end
  describe "signin" do
    
    describe "failure" do
      it "should not sign a user in" do
        visit signin_path
        fill_in "Email", :with => ""
        fill_in "Password", :with => ""
        click_button "Sign in"
        response.should have_selector('div.flash.error',
                                      :content => 'Invalid')
        response.should render_template('sessions/new')
      end
    end
    
    describe "success" do
      it "should sign a user in and out" do
        user = Factory(:user)
        visit signin_path
        fill_in "Email", :with => user.email
        fill_in "Password", :with => user.password
        click_button "Sign in"
        controller.should be_signed_in
        click_link "Sign out"
        controller.should_not be_signed_in
      end
    end
  end
end
