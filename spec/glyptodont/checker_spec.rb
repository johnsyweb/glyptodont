# frozen_string_literal: true

RSpec.describe Glyptodont::Checker do
  context "when using configuration" do
    subject(:checker) { described_class.new(args) }

    let(:args) { [] }
    let(:configuration) { instance_double(Glyptodont::Configuration, threshold: nil, max_age_in_days: nil) }

    before { allow(Glyptodont::Configuration).to receive(:new).and_return(configuration) }

    context "with defaults" do
      its(:threshold) { is_expected.to eq 10 }
      its(:max_age_in_days) { is_expected.to eq 14 }
    end

    context "with values in options" do
      let(:args) do
        [
          "--threshold", "2",
          "--max-age", "99"
        ]
      end

      its(:threshold) { is_expected.to eq 2 }
      its(:max_age_in_days) { is_expected.to eq 99 }
    end

    context "with values in config" do
      let(:configuration) { instance_double(Glyptodont::Configuration, threshold: 77, max_age_in_days: 1111) }

      its(:threshold) { is_expected.to eq 77 }
      its(:max_age_in_days) { is_expected.to eq 1111 }
    end

    context "with command-line options overriding config" do
      let(:configuration) { instance_double(Glyptodont::Configuration, threshold: 77, max_age_in_days: 1111) }
      let(:args) do
        [
          "--threshold", "123",
          "--max-age", "987"
        ]
      end

      its(:threshold) { is_expected.to eq 123 }
      its(:max_age_in_days) { is_expected.to eq 987 }
    end
  end
end
