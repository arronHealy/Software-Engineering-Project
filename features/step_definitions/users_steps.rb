Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create user
  end
end

Then /I should see user "(.*)" before user "(.*)"/ do |e1, e2|
  expect(page.body.index(e1) < page.body.index(e2))
end

Then /I should see all the users/ do
  User.all.each do |user|
    step %{I should see "#{user.email}"}
  end
end
