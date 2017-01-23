#!/usr/bin/env ruby
# frozen_string_literal: true

require 'rubygems'
require 'octokit'
require 'dotenv'
require 'date'

Dotenv.load
Octokit.configure do |c|
  c.login = ENV['GITHUB_USERNAME']
  c.password = ENV['GITHUB_PASSWORD']
end

# Fetch the current user
repo = Octokit::Repository.from_url(ENV['BLOG_REPOSITORY'])
puts "Checking #{repo.slug} for anything that needs to be posted today."

date_string = DateTime.now.strftime('%Y-%m-%d')
expected_branch_name = ENV['BRANCH_NAME_TEMPLATE'].gsub('%', date_string)

branches = Octokit.branches(repo)
branch = branches.detect { |b| b.name == expected_branch_name }

if branch.nil?
  puts "No branch named '#{expected_branch_name}'. Exiting."
  exit
end

puts "#{branch[:name]} found."

pull_request = Octokit.create_pull_request(repo, 'master', branch[:name],
  "Pushing scheduled post for #{date_string}", '')
puts "Pull request \##{pull_request[:number]} created."

commit_info = Octokit.merge_pull_request(repo, pull_request[:number])

if commit_info[:merged]
  puts "Pull request merged with message: #{commit_info[:message]}"
else
  puts "Pull failed to merged with message: #{commit_info[:message]}"
end
