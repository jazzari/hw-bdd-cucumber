# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
  #fail "Unimplemented"
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |item1, item2|
  #  ensure that that e1 occurs before e2.
  page.body.should =~ /#{item1}.*#{item2}/m
  #fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I check the following ratings: (.*)/ do |rating_list|
  # HINT: use String#split to split up the rating_list, then
  ratings = rating_list.split(", ")
  ratings.each do |rating|
  check("ratings_#{rating}")
  end
end

When /I uncheck the following ratings: (.*)/ do |rating_list|
  # HINT: use String#split to split up the rating_list, then
  ratings = rating_list.split(", ")
  ratings.each do |rating|
  uncheck("ratings_#{rating}")
  end
end

When(/^I press Refresh$/) do
  click_button('Refresh')
end

Then(/^I should see "([^"]*)" and "([^"]*)" rated movies$/) do |arg1, arg2|

  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

Then(/^I should not see "([^"]*)", "([^"]*)", "([^"]*)" rated movies$/) do |arg1, arg2, arg3|
  page.body.should_not match(/<td>#{arg1}<\/td>/)
  page.body.should_not match(/<td>#{arg2}<\/td>/)
  page.body.should_not match(/<td>#{arg3}<\/td>/)
end

Then(/^I should see all of the movies$/) do
  rows = page.all('tr#movies').size
  expect(rows).to eq(10)
end
