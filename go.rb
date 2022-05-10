require 'octokit' # gem install octokit
regex = /t\(["']/
GITHUB_ACCESS_TOKEN = ENV["GITHUB_ACCESS_TOKEN"]
client = Octokit::Client.new(:access_token => GITHUB_ACCESS_TOKEN)
ticket_number = 0
Dir.glob("**/*.html.erb").each do |filename|
  if File.read(filename).match? regex
    # client.create_issue('rubyforgood/casa', 'test', 'test')
    title = "Railsconf #{ticket_number}: update t() in #{filename}"
    body = %Q{Thank you for coming to our workshop!

To complete this issue, open `#{filename}` and find each call of `t(STRING)`, look up `STRING` in
config/locales/views.en.yml, and replace the call with the translation. This will simplify our templates and
make it easier to maintain the code going forward.

Example:

```
Before:
<span><%= t(".title") %></span>

In config/locales/views.en.yml
en:
  controller_name:
    view_name:
      title: Hello world

After:
<span>Hello world</span>
```

### Questions? Join Slack!

We highly recommend that you join us in slack https://rubyforgood.herokuapp.com/ #casa channel to ask questions quickly and hear about office hours (currently Tuesday 6-8pm Pacific), stakeholder news, and upcoming new issues.
}
    response = client.create_issue('compwron/practice-ticket-creation', title, body, labels: ['railsconf2022workshop'])
    issue_number = response[:number]
    p "created issue #{issue_number} for #{filename}"
    ticket_number += 1
    break
  end
end
