# frozen_string_literal: true

RSpec.describe Glyptodont::Checkers::Counter do
  describe "#check" do
    subject(:checker) { described_class.new(todos: todos, threshold: threshold) }

    context "no todos" do
      let(:todos) { [] }
      let(:threshold) { 1 }

      it { is_expected.to be_passed }
      its(:check) { is_expected.to eq "All done" }
    end

    context "below threshold" do
      let(:todos) { [{}] }
      let(:threshold) { 2 }

      it { is_expected.to be_passed }
      its(:check) { is_expected.to eq "1 TODO: This is tolerable" }
    end

    context "at threshold" do
      let(:todos) { [{}] }
      let(:threshold) { 1 }

      it { is_expected.to be_passed }
      its(:check) { is_expected.to eq "1 TODO: This is tolerable" }
    end

    context "over threshold" do
      let(:todos) do
        [
          { file: "example.txt", line: 1, text: "// Shall fix this", name: "paj", time: "yesterday" },
          { file: "example.txt", line: 2, text: "// Shall fix that", name: "paj", time: "today" }
        ]
      end
      let(:threshold) { 1 }

      it { is_expected.not_to be_passed }
      its(:check) do
        is_expected.to eq '2 TODOs: There is work to be done:
example.txt:1: // Shall fix this -- paj @ yesterday
example.txt:2: // Shall fix that -- paj @ today'
      end
    end
  end
end
