# frozen_string_literal: true

# String formatting methods
module Glyptodont
  class << self
    def pluralize(items, text)
      if items == 1
        "1 #{text}"
      else
        "#{items} #{text}s"
      end
    end

    def format_todo(todo)
      format("%<file>s:%<line>s: %<text>s -- %<name>s @ %<time>s", todo)
    end
  end
end
