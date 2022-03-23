# frozen_string_literal: true

require_relative "version"

require "optparse"

module Glyptodont
  # Command-line options for the tool
  class Options
    attr_reader :directory, :threshold, :max_age_in_days, :keywords

    def initialize(args)
      @args = args
      @directory = "."
      parse
    end

    private

    def parse
      OptionParser.new do |opts|
        opts.banner = "Usage: #{opts.program_name} [options]"

        directory_option(opts)
        threshold_option(opts)
        max_age_in_days_option(opts)
        keywords_option(opts)
        version_option(opts)
      end.parse!(@args)
    end

    def directory_option(opts)
      opts.on("-d", "--directory DIRECTORY", String, "Git repository to search for TODOs (default '.')") do |d|
        @directory = d
      end
    end

    def threshold_option(opts)
      opts.on("-t", "--threshold TODOS", Integer, "Maximum number of TODOs to allow (default 10)") do |t|
        @threshold = t
      end
    end

    def max_age_in_days_option(opts)
      opts.on("-m", "--max-age DAYS", Integer, "Maximum number of days to allow TODOs to stay (default 14)") do |m|
        @max_age_in_days = m
      end
    end

    def keywords_option(opts)
      opts.on("-k",
              "--keywords TODO,WORDS",
              Array,
              "Keywords to treat as 'TODO' (default FIXME,HACK,TODO,XXX)") do |k|
        @keywords = k
      end
    end

    def version_option(opts)
      opts.on_tail("--version", "Show version") do
        puts VERSION
        exit
      end
    end
  end
end
