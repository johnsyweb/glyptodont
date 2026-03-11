# frozen_string_literal: true

RSpec.describe Glyptodont::TodoResearcher do
  subject(:researcher) do
    described_class.new(directory, ignore, keywords, documentation_files)
  end

  let(:directory) { "/repo" }
  let(:ignore) { Set.new }
  let(:keywords) { %w[TODO] }
  let(:documentation_files) { [] }
  let(:git) { instance_double(Git::Base) }

  before do
    allow(Git).to receive(:open).with(directory).and_return(git)

    repository = instance_double(Rugged::Repository)
    blame = instance_double(Rugged::Blame)
    # rubocop:disable RSpec/VerifiedDoubles
    line_info = double("Rugged::Blame::Hunk")
    # rubocop:enable RSpec/VerifiedDoubles

    allow(Rugged::Repository).to receive(:new).with(directory).and_return(repository)
    allow(Rugged::Blame).to receive(:new).and_return(blame)
    allow(blame).to receive(:for_line).and_return(line_info)
    allow(line_info).to receive(:[]).with(:final_signature).and_return(
      time: Time.now,
      author: "Author",
      email: "author@example.com"
    )

    allow(git).to receive(:grep).and_return(
      "sha:docs/index.html" => [[10, "  # TODO: update docs\n"]],
      "sha:lib/glyptodont/core.rb" => [[5, "  # TODO: refactor\n"]]
    )
  end

  describe "#research" do
    context "when documentation_files is empty" do
      it "includes TODOs from all files" do
        files = researcher.research.map { |t| t[:file] }

        expect(files).to contain_exactly("docs/index.html", "lib/glyptodont/core.rb")
      end
    end

    context "when documentation_files lists a documentation file" do
      let(:documentation_files) { ["docs/index.html"] }

      it "excludes TODOs from documentation files" do
        files = researcher.research.map { |t| t[:file] }

        expect(files).to contain_exactly("lib/glyptodont/core.rb")
      end
    end
  end
end
