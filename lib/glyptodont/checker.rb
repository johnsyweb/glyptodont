# frozen_string_literal: true

require "forwardable"

module Glyptodont
  # This is where the magic happens
  class Checker
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
      options.threshold || configuration.threshold
    end

    def max_age_in_days
      options.max_age_in_days || configuration.max_age_in_days
    end
  end
end
