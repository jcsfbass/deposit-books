#!/usr/bin/env rake

require 'rspec/core/rake_task'

namespace :test do
	RSpec::Core::RakeTask.new(:spec) do |t|
		t.pattern = Dir.glob('tests/unit/**/*_spec.rb')
	end

	task unit: :spec
end