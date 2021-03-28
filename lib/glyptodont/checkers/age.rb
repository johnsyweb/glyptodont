# frozen_string_literal: true

module Glyptodont
  module Checkers
    # Checks that the age of TODOs is below the specified threshold
    class Age
      def initialize(todos:, threshold:)
        @todos = todos
        @threshold = threshold
      end

      def check
        message
      end

      def passed?
        stale_todos.empty?
      end

      private

      attr_reader :todos, :threshold

      def message
        if todos.empty?
          "Nothing left to do"
        elsif passed?
          "At #{Glyptodont.pluralize(oldest_age, "day")}, TODOs are fresh enough for now"
        else
          "Some TODOs are too stale at more than #{Glyptodont.pluralize(youngest_stale - 1, "day")} old:\n" +
            stale_todos.map { |t| Glyptodont.format_todo(t) }.join("\n")
        end
      end

      def stale_todos
        @stale_todos ||= todos.select { |todo| todo[:age] > threshold }
                              .sort_by { |todo| todo[:age] }
                              .reverse
      end

      def oldest_age
        todos.max_by { |t| t[:age] }[:age]
      end

      def youngest_stale
        stale_todos.last[:age]
      end
    end
  end
end
