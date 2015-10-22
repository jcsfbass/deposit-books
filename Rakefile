#!/usr/bin/env rake

require 'rspec/core/rake_task'

namespace :test do
	RSpec::Core::RakeTask.new(:unit) do |t|
		t.pattern = Dir.glob('tests/unit/**/*_spec.rb')
	end

	RSpec::Core::RakeTask.new(:api) do |t|
		t.pattern = Dir.glob('tests/api/*_spec.rb')
	end

	task all: ['test:unit', 'test:api'] do
	end
end