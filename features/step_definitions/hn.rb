#
# features/step_definitions/hn.rb
#

Then /^I should see page_has_link "([^"]*)"$/ do |link_name|
  assert(false,"Page is missing link: #{link_name}") unless page.has_link? link_name
end

Then /^I should see page_has_no_link "([^"]*)"$/ do |link_name|
  assert(false,"Page should not have this link: #{link_name}") if page.has_link? link_name
end

Then /^I should see page_has_selector "([^"]*)"$/ do |sel_name|
  page.should have_selector(sel_name)
end

Then /^I should see page_has_field "([^"]*)"$/ do |id|
  page.should have_selector('input#' + id)
end

Then /^I login_as "(.*)\/(.*)"$/ do |email, password|
  step %{I sign out}
  step %{I go to the home page}
  step %{I follow "Register"}
  step %{I fill in "Email" with "#{email}"}
  step %{I press "Signup"}
  # get the conf-token from AR
  @usr = User.find_by_email email
  @token = @usr.confirmation_token
  # visit conf page
  @cpath = "/users/confirmation?confirmation_token=#{@token}"
  visit @cpath
  # enter the password
  step %{I fill in "Password" with "#{password}"}
  step %{I fill in "Password confirmation" with "#{password}"}
  click_button "Press This"
end

Then /^I visit "([^"]*)"$/ do |path_name|
  visit path_name
end

Then /^My current_path should be "([^"]*)"$/ do |the_path|
  current_path.should == the_path
end

Then /^My feature_path should be "([^"]*)"$/ do |a_routes_path|
  # My call to send() needs parenthesis or else I get a syntax error:
  current_path.should == send(a_routes_path)
end

Then /^I_follow_reset_password_mail_for "([^"]*)"$/ do |email|
  @usr = User.find_by_email email
  @rptoken = @usr.reset_password_token
  @rpath = "/users/password/edit?reset_password_token=#{@rptoken}"
  visit @rpath
end
