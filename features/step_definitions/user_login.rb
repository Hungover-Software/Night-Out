When /^I go to the "(.*)"/ do |place|
 visit "/#{place}"
end

When(/^I enter the information for my account$/) do
    
    visit "/login"
    within "welcme#index" do
        fill_in 'Username', :with => 'test@gmail.com'
        fill_in 'Password', :with => 'foobar'
    end

end

When(/^press the Submit button$/) do
  click_button 'Submit'
end

Then(/^I should be redirected to the home page$/) do
 expect(page).to have_content ''
end