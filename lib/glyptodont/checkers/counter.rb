# frozen_string_literal: true

module Glyptodont
  module Checkers
    # Checks that the number of TODOs is below the specified threshold
    class Counter
      def initialize(todos:, threshold:)
        @threshold = threshold
        @todos = todos
      end

      def check
        message
      end

      def passed?
        count <= threshold
      end

      private

      def count
        @count ||= todos.size
      end

      def message
        if count.zero?
          "All done"
        elsif passed?
          "#{Glyptodont.pluralize(count, "TODO")}: This is tolerable"
        else
          "#{Glyptodont.pluralize(count, "TODO")}: There is work to be done:\n" +
            todos.map { |t| Glyptodont.format_todo(t) }.join("\n")
        end
      end

      attr_reader :todos, :threshold
    end
  end
end
