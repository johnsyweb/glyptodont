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
        @age, @reportable_todos = oldest_todos
        message
      end

      def passed?
        todos.empty? || age <= threshold
      end

      private

      attr_reader :todos, :threshold, :age, :reportable_todos

      def message
        if todos.empty?
          "Nothing left to do"
        elsif passed?
          "At #{Glyptodont.pluralize(age, "day")}, TODOs are fresh enough for now"
        else
          "Some TODOs are too stale at #{Glyptodont.pluralize(age, "day")} old:\n" +
            reportable_todos.map { |t| Glyptodont.format_todo(t) }.join("\n")
        end
      end

      def oldest_todos
        todos.group_by { |todo| todo[:age] }
             .max_by { |age, _group| age }
      end
    end
  end
end
