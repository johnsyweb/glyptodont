# Glyptodont

Use this gem if you have ever deployed code to production without doing all of
your to-dos.

## Introduction

All of the glyptodonts have fossilised. This is a tool to ensure that your TODOs
are eradicated before this can happen to them.

If you've ever been caught out because a TODO in production code has not been
_done_, this gem is for ***you***!

## Development status [![Ruby](https://github.com/johnsyweb/glyptodont/actions/workflows/main.yml/badge.svg)](https://github.com/johnsyweb/glyptodont/actions/workflows/main.yml)

This was written after I was bitten by a TODO not being _done_ at work. I expect
to build it into our CI pipeline and see what it catches.

After checking out the project, run `script/setup` to install dependencies. Then,
run `script/tests` to run the tests. You can also run `script/console` for an
interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and the created tag, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Getting started [![Gem version](https://img.shields.io/gem/v/glyptodont.svg?style=flat-square)](https://github.com/johnysweb/glyptodont) [![Gem downloads](https://img.shields.io/gem/dt/glyptodont.svg?style=flat-square)](https://rubygems.org/gems/glyptodont)

Add this line to your application's Gemfile:

```ruby
gem 'glyptodont'
```

And then execute:

```sh
bundle install
```

Or install it yourself as:

```sh
gem install glyptodont
```

## Usage

```
Usage: glyptodont [options]
    -d, --directory DIRECTORY        Git repository to search for TODOs (default '.')
    -t, --threshold TODOS            Maximum number of TODOs to allow (default 10)
    -m, --max-age DAYS               Maximum number of days to allow TODOs to stay (default 14)
        --version                    Show version
```

## Configuration

glyptodont looks for an optional `.glyptodont.yaml` configuration file in the
root of the directory being scanned.

### Sections

- `threshold`: Maximum number of TODOs to allow. Can be overridden by
  command-line options.
- `max_age_in_days`: Maximum number of days to allow TODOs to stay. Can be
  overridden by command-line options.
- `ignore`: List of `file_name:line_number` pairs to ignore when researching
  TODOs. This may be useful if you have, for example, Spanish language text in
  your project or you talk about TODOs a lot :-)

### _Exempli gratiā_

```yaml
---
threshold: 1
max_age_in_days: 1
ignore:
  - README.md:11
  - lib/glyptodont/checkers/counter.rb:30
  - lib/glyptodont/todo_researcher.rb:33
  - spec/checkers/counter_spec.rb:20
```

## Requirements

- Ruby (tested against v2.5 and above)
- Git
- CMake

## Contributing

Bug reports and pull requests are welcome on GitHub at
<https://github.com/johnsyweb/glyptodont>. This project is intended to be a
safe, welcoming space for collaboration, and contributors are expected to adhere
to the [code of
conduct](https://github.com/johnsyweb/glyptodont/blob/master/CODE_OF_CONDUCT.md).

## License [![license](https://img.shields.io/github/license/mashape/apistatus.svg?style=flat-square)](https://github.com/johnsyweb/glyptodont/blob/HEAD/LICENSE.txt)

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Glyptodont project's codebases, issue trackers, chat
rooms and mailing lists is expected to follow the [code of
conduct](https://github.com/johnsyweb/glyptodont/blob/master/CODE_OF_CONDUCT.md).

## See also

<https://github.com/johnsyweb/glyptodont-docker> to run this in a container,
ideal for your CI pipeline.
