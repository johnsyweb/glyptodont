# frozen_string_literal: true

require "set"
require "yaml"

module Glyptodont
  # Allow for configuring the tool
  class Configuration
    FILENAME = ".glyptodont.yaml"
    DEFAULT_THRESHOLD = 10
    DEFAULT_MAX_AGE_IN_DAYS = 14

    def initialize(directory)
      @config_filename = File.join(directory, FILENAME)
    end

    def ignore
      @ignore ||= extract_ignore_set || []
    end

    def threshold
      @threshold ||= config.fetch("threshold", DEFAULT_THRESHOLD)
    end

    def max_age_in_days
      @max_age_in_days ||= config.fetch("max_age_in_days", DEFAULT_MAX_AGE_IN_DAYS)
    end

    private

    attr_reader :config_filename

    def config
      @config ||= if File.exist?(config_filename)
                    YAML.load_file(config_filename, fallback: {})
                  else
                    {}
                  end
    end

    def extract_ignore_set
      config.fetch("ignore", []).map do |line|
        parts = line.split(":", 2)
        {
          file: parts[0],
          line: parts[1].to_i
        }
      end.to_set
    end
  end
end
