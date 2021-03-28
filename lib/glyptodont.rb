# frozen_string_literal: true

require_relative "glyptodont/checker"

# Entry point
module Glyptodont
  def self.check
    Checker.new(ARGV).check
  end
end
