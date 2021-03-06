#!/usr/bin/env ruby
require 'yaml'

# This script builds a link for comparing versions when PR environment files and it adds it as a comment
# Usage example:
# ruby lib/versions_extractor.rb $GITHUB_BEFORE $GITHUB_AFTER "mymeds-stg.yml" $PR_NUMBER ${{steps.filter.outputs.production}} ${{steps.filter.outputs.validation}} ${{steps.filter.outputs.experimental}} ${{steps.filter.outputs.stage}} ${{steps.filter.outputs.training}}
# Arguments:
# ARGV[0]: $GITHUB_BEFORE -> ${{ github.event.before }}
# ARGV[1]: $GITHUB_AFTER -> ${{ github.event.after }}
# ARGV[2]: File name
# ARGV[3]: $PR_NUMBER -> ${{github.event.pull_request.number}}
# From ARGV[4] to ARGV[8], booleans for environments

def find_version(hash)
  cc = hash["components"].find { |c| c["repo_name"] == "customer_configurations" }
  cc["version"] if cc
end

# Gets previous version of the modified file
if ARGV[4] == "true"
  current_file = "#{ARGV[2]}-prod.yml"
elsif ARGV[5] == "true"
  current_file = "#{ARGV[2]}-val.yml"
elsif ARGV[6] == "true"
  current_file = "#{ARGV[2]}-exp.yml"
elsif ARGV[7] == "true"
  current_file = "#{ARGV[2]}-stg.yml"
elsif ARGV[8] == "true"
  current_file = "#{ARGV[2]}-trg.yml"
else
  puts "Nothing to do here"
end

before = YAML.load `git show #{ARGV[0]}:#{current_file}`
# Gets updated version of the modified file
after = YAML.load `git show #{ARGV[1]}:#{current_file}`

body_text = "Please, visit for checking the changes in #{current_file}: <a>https://github.com/MyMedsAndMe/customer_configurations/compare/#{find_version(before)}...#{find_version(after)}?expand=1</a>"
# Run github cli command to add a comment to the PR
puts `gh pr comment "#{ARGV[3]}" --body "#{body_text}"`
