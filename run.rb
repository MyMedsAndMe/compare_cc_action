#!/usr/bin/env ruby
# require 'yaml'

# This script builds a link for comparing versions when PR environment files and it adds it as a comment
# Usage example:
# ruby lib/versions_extractor.rb $GITHUB_BEFORE $GITHUB_AFTER "mymeds-stg.yml" $PR_NUMBER 
# Arguments:
# ARGV[0]: $GITHUB_BEFORE -> ${{ github.event.before }}
# ARGV[1]: $GITHUB_AFTER -> ${{ github.event.after }}
# ARGV[2]: File name
# ARGV[3]: $PR_NUMBER -> ${{github.event.pull_request.number}}
# ARGV[4]: environment
def find_version(hash)
  cc = hash["components"].find { |c| c["repo_name"] == "customer_configurations" }
  cc["version"] if cc
end

puts "This is ARGV-0: #{ARGV[0]}"
puts "This is ARGV-1: #{ARGV[1]}"
puts "This is ARGV-0: #{ARGV[2]}"
puts "This is ARGV-0: #{ARGV[3]}"
puts "This is ARGV-0: #{ARGV[4]}"
# Gets previous version of the modified file
# current_environment = ARGV[4]
# if current_environment.production == true
#   current_file = "#{ARGV[2]}-prod.yml"
# elsif current_environment.experimental == true
#   current_file = "#{ARGV[2]}-exp.yml"
# elsif current_environment.training == true
#   current_file = "#{ARGV[2]}-trg.yml"
# elsif current_environment.stage == true
#   current_file = "#{ARGV[2]}-stg.yml"
# elsif current_environment.validation == true
#   current_file = "#{ARGV[2]}-val.yml"
# else
#   puts "Nothing to do here"
# end
# before = YAML.load `git show #{ARGV[0]}:#{current_file}`
# # Gets updated version of the modified file
# after = YAML.load `git show #{ARGV[1]}:#{current_file}`

# body_text = "Please, visit for checking the changes in #{current_file}: <a>https://github.com/MyMedsAndMe/customer_configurations/compare/#{find_version(before)}...#{find_version(after)}?expand=1</a>"
# # Run github cli command to add a comment to the PR
# puts `gh pr comment "#{ARGV[3]}" --body "#{body_text}"`
