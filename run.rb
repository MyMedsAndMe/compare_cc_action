#!/usr/bin/env ruby
require 'yaml'

# This script builds a link for comparing versions when PR environment files and it adds it as a comment
# Usage example:
# ruby lib/versions_extractor.rb $GITHUB_BEFORE $GITHUB_AFTER "mymeds-stg.yml" $PR_NUMBER 
# Arguments:
# ARGV[0]: $GITHUB_BEFORE -> ${{ github.event.before }}
# ARGV[1]: $GITHUB_AFTER -> ${{ github.event.after }}
# ARGV[2]: File name
# ARGV[3]: $PR_NUMBER -> ${{github.event.pull_request.number}}
def find_version(hash)
  cc = hash["components"].find { |c| c["repo_name"] == "customer_configurations" }
  cc["version"] if cc
end
# Gets previous version of the modified file
before = YAML.load `git show #{ARGV[0]}:#{ARGV[2]}`
# Gets updated version of the modified file
after = YAML.load `git show #{ARGV[1]}:#{ARGV[2]}`

body_text = "Please, visit for checking the changes in #{ARGV[2]}: <a>https://github.com/MyMedsAndMe/customer_configurations/compare/#{find_version(before)}...#{find_version(after)}?expand=1</a>"
# Run github cli command to add a comment to the PR
puts `gh pr comment "#{ARGV[3]}" --body "#{body_text}"`
