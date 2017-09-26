# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  value = 0
  movies_table.hashes.each do |movie|
    Movie.create(movie)
    value += 1
  end
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  matches = page.text.should match(/#{e1}.*#{e2}/)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.delete!("\"")
  if uncheck.nil?
    rating_list.split(',').each do |field|
      check("ratings["+field.strip+"]")
    end
  else
    rating_list.split(',').each do |field|
      uncheck("ratings["+field.strip+"]")
    end
  end
end

Then /I should see all the movies/ do
  page.all("table#movies tbody tr").count.should == Movie.count
end
