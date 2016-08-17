require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require File.expand_path("../lib/omniauth/mercadopago/version", __FILE__)

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rspec_opts = ['--color']
end

task default: :spec

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
