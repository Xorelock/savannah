#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Savannah::Application.load_tasks

task :agentrun do
  require 'lib/aies'
  myagent = Aies::Agent.new("test", "http://localhost:3030")
  puts myagent.inspect
  puts "and done"
end