#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require File.expand_path("../lib/omniauth-mercadopago/version", __FILE__)

RSpec::Core::RakeTask.new

begin
  require "rubocop/rake_task"
  RuboCop::RakeTask.new
rescue LoadError
  task :rubocop do
    $stderr.puts "RuboCop is disabled"
  end
end

task test: :spec

task :build do
  sh "gem build omniauth-mercadopago.gemspec"
end

task release: :build do
  sh "git push origin master"
  sh "gem push omniauth-mercadopago-#{OmniAuth::Mercadopago::VERSION}.gem"
end

task :console do
  sh "irb -rubygems -I lib/omniauth -r mercadopago.rb"
end

task default: [:spec, :rubocop]
