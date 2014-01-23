#!/usr/bin/env rake
require 'rspec/core'
require 'rspec/core/rake_task'
require 'jasmine'
load 'jasmine/tasks/jasmine.rake'

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

task :default => :spec