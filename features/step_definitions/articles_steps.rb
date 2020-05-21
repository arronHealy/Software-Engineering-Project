Given /the following articles exist/ do |articles_table|
  articles_table.hashes.each do |article|
    Article.create article
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  expect(page.body.index(e1) < page.body.index(e2))
end

Then /I should see all the articles/ do
  Article.all.each do |article|
    step %{I should see "#{article.title}"}
  end
end

Then /^the creator of "([^"]*)" should be "([^"]*)"$/ do |article, creator|
    step %{I should see "#{article}"}
    step %{I should see "#{creator}"}
end