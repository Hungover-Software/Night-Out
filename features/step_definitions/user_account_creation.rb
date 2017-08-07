
When(/^I navigate to the create_account page$/) do
  visit('/create_account')
  expect(page).to have_content 'Create Account'
end

  
When(/^I enter all the information for my account$/) do
 #within ".signup" do
  #fill_in 'Email', :with => 'test@gmail.com'
  #fill_in 'Password', :with => 'foobar'
  #fill_in 'Confirm Password', :with => 'foobar'
  #fill_in 'Preferred Name', :with => 'test'
  #fill_in 'Phone', :with => '4021231234'
  #end
 
 User.new(email: "test@gmail.com", password: "foobar", password_confirmation: "foobar", preferred_name: "test", phone: "4021231234")

end

When(/^press the Signup button$/) do
  click_button 'Signup'
end

Then(/^I should be redirected to the login page$/) do
  expect(page).to have_content 'Sign In'
end