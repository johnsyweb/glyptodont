# frozen_string_literal: true

require_relative "glyptodont/checker"
require_relative "glyptodont/checkers/age"
require_relative "glyptodont/checkers/counter"
require_relative "glyptodont/configuration"
require_relative "glyptodont/formatting"
require_relative "glyptodont/options"
require_relative "glyptodont/todo_researcher"

module Glyptodont
  def self.check
    Checker.new(ARGV).check
  end
end
