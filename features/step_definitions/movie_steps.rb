require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  a = 0
  Movie.delete_all
  movies_table.hashes.each do |movie|
    a += 1
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    #    length = Movie.find(:all).length
    #    length.should == 0

    assert movies_table.hashes.length == 10, "there are many more movies"
    m = Movie.create
    m.title = movie['title']
    m.rating = movie['rating']
    m.release_date = Time.parse(movie['release_date'])
    m.save
  end
  assert a == 10, "more iterations done"
  assert Movie.find(:all).length.should == 10,  "final movies inserted more than 10"
  #assert false, "Unimplmemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  assert false, "Unimplmemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(", ").each do |rate|
    if uncheck
      step %(I uncheck "ratings_#{rate}")
    else
      step %(I check "ratings_#{rate}")
    end
  end
    

#  end
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
end

When /^I check the "([^"]*)" checkbox$/ do |rating|
  step %(I check "ratings_#{rating}")
end

Then /^I should see (.*) of the movies I entered$/ do |see|
  case see.to_sym 
  when  :all
    all("table#movies tr .movieTitle").count.should == 10
  when :none
    all("table#movies tr .movieTitle").count.should == 0
  end
end


Then /^I should (not )?see movies with rates: (.*)$/ do |must_not_be_seen, ratings|
  checked_ratings = ratings.split(", ")
  all("table#movies tr .movieRating").each do |tr_node|
    if must_not_be_seen
      checked_ratings.should_not include tr_node.text
    else
      checked_ratings.should include tr_node.text
    end
  end        
end


Given /^I checked (.*) ratings$/ do |input|
#  all(".rating_type").count.should == 5
  all(".rating_type").each do |node|
    case input.to_sym
    when :all
      check node[:name]
    when :no
      uncheck node[:name]
    end    
  end
#  all(".rating_type").each do |node_s|
#    node_s.checked?.should == "checked"
#  end
end

#When /^I 





