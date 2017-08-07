Feature: User Sign-up
As a new user
I want to create a new account
So that I can use the application

Scenario: User creates a new account
When I navigate to the create_account page
When I enter all the information for my account
And press the Signup button
Then I should be redirected to the login page
