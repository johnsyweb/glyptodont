# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- xp
- drop support for Ruby < 3.2 (EOL); require Ruby 3.2+
- add conventional commits changelog and release workflow
- enforce conventional commits and run checks before each commit
- add Release Please release bot
- publish gem to RubyGems via Trusted Publishing on tag push
- add documentation page for GitHub Pages
- set homepage to docs at www.johnsy.com/glyptodont/
- add Dependabot and automerge workflow for dependency updates
- remove automerge setup note from README
- check conventional commits only from first conventional commit onwards
- add .nojekyll so GitHub Pages does not use Jekyll

## [0.3.1] - 2026-03-11

### Fixed

- Do not require `bundler/setup` in the executable. The gem now runs correctly when the current directory has a Gemfile (e.g. in CI or when running in the gem's own repo).

## [0.3.0] - 2022-03-23

### Changed

- Fix link

- tyop

- Support Ruby 2.5 through 3.1

- Add Rubocop plugins

- Improve gem description

- Gemspec/RequireMFA

- Lint/AmbiguousOperatorPrecedence

- Update Changelog

- Add keywords option/configuration for TODO synonyms

- v0.3.0

- 2022

- Changelog for v0.3.0

- Fix anchor


## [0.2.0] - 2021-03-28

### Changed

- TODOs have moved

- Cache the annotator for a file

- See also!

- return empty hash if the config file is empty

- add rspec-its

- add cmd-line options into config

- pass ARGV to the initializer not the check

- report all old TODOs, use age of the youngest in message

- passing case wasn't handling the new threshold checking, fixed now

- Style

- Move requirements around

- Extract #stale_todos and #oldest_age

- Spec for counter

- Update configuration file

- Document new configuration options

- Changelog for v0.2.0

- Fake configuration to make tests pass again

- Run rubocop in ci

- Bump version


## [0.1.0] - 2021-03-16

### Changed

- Initial version

- //xkcd.com/149/

- Allow for excluding certain lines

- Handle missing / empty configuration

- All or nothing

- Use OptionParser to document command-line options

- Please Read Me

- Test more Rubies


[Unreleased]: https://github.com/johnsyweb/glyptodont/compare/v0.3.0..HEAD
[0.3.0]: https://github.com/johnsyweb/glyptodont/compare/v0.2.0..v0.3.0
[0.2.0]: https://github.com/johnsyweb/glyptodont/compare/v0.1.0..v0.2.0
[0.1.0]: https://github.com/johnsyweb/glyptodont/releases/tag/v0.1.0

