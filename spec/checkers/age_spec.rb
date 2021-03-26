# frozen_string_literal: true

RSpec.describe Glyptodont::Checkers::Age do
  def todo(age)
    {
      file: "example.rb",
      line: rand(1000),
      text: "exmaple text",
      name: "name",
      time: Time.now - age * (24 * 60 * 60),
      age: age
    }
  end

  subject(:checker) { described_class.new(todos: todos, threshold: max_age) }

  let(:todos) do
    [
      *todos_over_threshold,
      todo(1),
      todo(2),
      todo(3),
      todo(7)
    ].shuffle
  end

  let(:todos_over_threshold) do
    [
      todo(11),
      todo(14),
      todo(15),
      todo(17),
      todo(300),
      todo(18)
    ].sort_by { |t| t[:age] }.reverse
  end

  let(:max_age) { 10 }

  it "reports on all todos that exceed the threshold" do
    expect(checker.check).to include(todos_over_threshold.map { |t| Glyptodont.format_todo(t) }.join("\n"))
  end

  it "reports the age of the youngest todo that exceeds the threshold" do
    expect(checker.check).to include("Some TODOs are too stale at more than #{Glyptodont.pluralize(max_age, "day")} old:")
  end
end
