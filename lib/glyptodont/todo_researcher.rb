# frozen_string_literal: true

require "git"
require "rugged"

module Glyptodont
  # Finds all the TODOs in a directory managed by Git, who last touched them and when.
  class TodoResearcher
    def initialize(directory, ignore)
      @directory = directory
      @ignore = ignore
      @annotator = {}
    end

    def research
      annotate(exclude_ignored(extract_details(git.grep(keyword_rexexp))))
    end

    private

    attr_reader :directory, :ignore

    def git
      Git.open(directory)
    end

    def keyword_rexexp
      "\\b\\(#{keywords.join('\|')}\\)\\b"
    end

    def keywords
      %w[
        FIXME
        HACK
        TODO
        XXX
      ]
    end

    def extract_details(todos)
      todos.flat_map do |sha, matches|
        file = sha.split(":", 2).last
        matches.map do |match|
          {
            file: file,
            line: match[0],
            text: match[1].strip
          }
        end
      end
    end

    def exclude_ignored(todos)
      todos.reject { |todo| ignore.include?(todo.slice(:file, :line)) }
    end

    def annotate(todos)
      todos.map do |todo|
        annotation = annotate_line(file_path: todo[:file], line_number: todo[:line])
        todo.merge(annotation).merge(age: days_since(annotation[:time]))
      end
    end

    def annotate_line(file_path:, line_number:)
      line_info(file_path: file_path, line_number: line_number)[:final_signature]
    end

    def line_info(file_path:, line_number:)
      @annotator[file_path] ||= Rugged::Blame.new(repository, file_path)
      @annotator[file_path].for_line(line_number)
    end

    def repository
      @repository ||= Rugged::Repository.new(directory)
    end

    def days_since(timestamp)
      (Time.now - timestamp).to_i / (24 * 60 * 60)
    end
  end
end
