# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new

desc "Regenerate CHANGELOG.md from conventional commits (requires git-cliff, e.g. via mise)"
task :changelog do
  system("git cliff -o CHANGELOG.md") || abort("changelog task failed")
end

task default: %i[spec rubocop]
