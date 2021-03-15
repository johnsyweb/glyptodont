# frozen_string_literal: true

require_relative "glyptodont/configuration"
require_relative "glyptodont/checkers/age"
require_relative "glyptodont/checkers/counter"
require_relative "glyptodont/formatting"
require_relative "glyptodont/todo_researcher"
require_relative "glyptodont/version"

# This is where the magic happens
module Glyptodont
  def self.check(directory:, threshold:, max_age_in_days:)
    ignore = Configuration.new(directory).ignore

    todos = TodoResearcher.new(directory, ignore).research

    checks = [
      Checkers::Counter.new(todos: todos, threshold: threshold),
      Checkers::Age.new(todos: todos, threshold: max_age_in_days)
    ].freeze

    checks.each { |check| puts check.check }

    checks.all?(&:passed?)
  end
end
