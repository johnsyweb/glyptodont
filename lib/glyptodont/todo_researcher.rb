# frozen_string_literal: true

require "git"
require "rugged"

module Glyptodont
  # Finds all the TODOs in a directory managed by Git, who last touched them and when.
  class TodoResearcher
    def initialize(directory, ignore, keywords, documentation_files = [])
      @directory = directory
      @ignore = ignore
      @keywords = Array(keywords)
      @documentation_files = Array(documentation_files)
      @annotator = {}
    end

    def research
      todos = extract_details(git.grep(keyword_rexexp))
      todos = exclude_documentation_files(todos)
      todos = exclude_ignored(todos)
      annotate(todos)
    end

    private

    attr_reader :directory, :ignore, :keywords, :documentation_files

    def git
      Git.open(directory)
    end

    def keyword_rexexp
      "\\b\\(#{keywords.join('\|')}\\)\\b"
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

    def exclude_documentation_files(todos)
      return todos if documentation_files.empty?

      todos.reject { |todo| documentation_files.include?(todo[:file]) }
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
