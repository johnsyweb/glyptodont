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
        @reportable_todos = oldest_todos
        message
      end

      def passed?
        reportable_todos.empty?
      end

      private

      attr_reader :todos, :threshold, :reportable_todos

      def message
        if todos.empty?
          "Nothing left to do"
        elsif passed?
          oldest = todos.max_by { |t| t[:age] }
          "At #{Glyptodont.pluralize(oldest[:age], "day")}, TODOs are fresh enough for now"
        else
          youngest_stale = reportable_todos.last[:age]
          "Some TODOs are too stale at more than #{Glyptodont.pluralize(youngest_stale - 1, "day")} old:\n" +
            reportable_todos.map { |t| Glyptodont.format_todo(t) }.join("\n")
        end
      end

      def oldest_todos
        todos.select { |todo| todo[:age] > threshold }
             .sort_by { |todo| todo[:age] }
             .reverse
      end
    end
  end
end
