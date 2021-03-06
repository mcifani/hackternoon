Feature: Sign out
  To protect my account from unauthorized access
  A signed in user
  Should be able to sign out

    @javascript
    Scenario: User signs out
      Given I exist as a user
      And I sign out
      And I sign in with a correct password
      Then I should see "Signed in successfully."
      And I follow "Logout"
      Then I should see "Signed out successfully"
      When I return next time
      Then I should see page_has_link "Register"
      And I should see page_has_link "Login"
      And I should see page_has_no_link "Logout"
