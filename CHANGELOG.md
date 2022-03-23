# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

[Unreleased]: https://github.com/johnsyweb/glyptodont/compare/v0.3.0..main

## [0.3.0] - 2022-03-23

### Added

- `keywords` option and configuration for TODO synonyms [[#5]]

### Changed

- Dropped support for Ruby version older than 2.5 [[#4]]

[#4]: https://github.com/johnsyweb/glyptodont/pull/4
[#5]: https://github.com/johnsyweb/glyptodont/pull/5
[Unreleased]: https://github.com/johnsyweb/glyptodont/compare/v0.2.0..v0.3.0

## [0.2.0] - 2021-03-28

### Added

- Configuration settings for `max_age_in_days` and `threshold`, to allow for
  setting these per project. [[#3]]

### Changed

- Report all old TODOs, use age of the youngest in message [[#2]]

### Fixed

- Handle empty configuration file [[#1]]

[#1]: https://github.com/johnsyweb/glyptodont/pull/1
[#2]: https://github.com/johnsyweb/glyptodont/pull/2
[#3]: https://github.com/johnsyweb/glyptodont/pull/3

[0.2.0]: https://github.com/johnsyweb/glyptodont/compare/v0.1.0..v0.2.0

## [0.1.0] - 2021-03-13

- Initial release

[0.1.0]: https://github.com/johnsyweb/glyptodont/releases/tag/v0.1.0
