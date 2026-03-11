# frozen_string_literal: true

RSpec.describe Glyptodont::Configuration do
  subject(:configuration) { described_class.new(directory) }

  let(:directory) { Dir.mktmpdir("glyptodont-config-spec") }

  after do
    FileUtils.remove_entry(directory) if File.directory?(directory)
  end

  def write_config(yaml)
    File.write(File.join(directory, ".glyptodont.yaml"), yaml)
  end

  describe "#documentation_files" do
    context "when configuration does not specify documentation_files" do
      before { write_config("---\nthreshold: 1\n") }

      it "returns an empty array" do
        expect(configuration.documentation_files).to eq([])
      end
    end

    context "when configuration specifies documentation_files" do
      before do
        write_config(<<~YAML)
          ---
          documentation_files:
            - CHANGELOG.md
            - docs/index.html
        YAML
      end

      it "returns the list of documentation files" do
        expect(configuration.documentation_files).to eq(
          ["CHANGELOG.md", "docs/index.html"]
        )
      end
    end
  end
end
