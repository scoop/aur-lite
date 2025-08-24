# Changelog

All notable changes to aur-lite will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - 2025-08-24

### Added
- Initial release of aur-lite
- Core functionality for installing AUR packages from GitHub mirror
- Two fetch modes: `partial` (cached) and `single` (no cache)
- Recursive dependency resolution for AUR packages
- Automatic installation of repository dependencies via pacman
- Environment variable configuration support
- Security hardening features:
  - Package name validation
  - Safe command execution
  - Cleanup traps for temporary files
  - File locking to prevent race conditions
- Debug mode with `VERBOSE=1` environment variable
- Support for `NOCHECK`, `NODEV`, and `NOINSTALL` build options
- Custom `MAKEPKG_OPTS` support for additional makepkg flags
- Worktree management for efficient git operations in partial mode
- Comprehensive error handling and cleanup

### Security
- Input validation for all package names
- Protection against shell injection attacks
- Strict package name validation before sudo operations
- Safe handling of git worktrees and temporary directories

[Unreleased]: https://github.com/scoop/aur-lite/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/scoop/aur-lite/releases/tag/v0.1.0