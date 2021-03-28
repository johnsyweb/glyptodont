# frozen_string_literal: true

require_relative "checkers/age"
require_relative "checkers/counter"
require_relative "configuration"
require_relative "formatting"
require_relative "options"
require_relative "todo_researcher"

require "forwardable"

module Glyptodont
  # Main class where all the work happens
  class Checker
    DEFAULT_THRESHOLD = 10
    DEFAULT_MAX_AGE_IN_DAYS = 14

    def initialize(args)
      @options = Options.new(args)
      @configuration = Configuration.new(directory)
    end

    def check
      todos = TodoResearcher.new(directory, ignore).research

      checks = [
        Checkers::Counter.new(todos: todos, threshold: threshold),
        Checkers::Age.new(todos: todos, threshold: max_age_in_days)
      ].freeze

      checks.each { |check| puts check.check }

      checks.all?(&:passed?)
    end

    attr_reader :configuration, :options

    extend Forwardable

    def_delegator :@configuration, :ignore
    def_delegators :@options, :directory

    def threshold
      options.threshold || configuration.threshold || DEFAULT_THRESHOLD
    end

    def max_age_in_days
      options.max_age_in_days || configuration.max_age_in_days || DEFAULT_MAX_AGE_IN_DAYS
    end
  end
end
