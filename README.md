# aur-lite

A lightweight, secure AUR (Arch User Repository) helper that installs packages directly from the GitHub read-only mirror without using the RPC API.

## Features

- **No RPC dependency** - Works directly with the GitHub mirror, avoiding AUR API rate limits
- **Minimal dependencies** - Only requires `git`, `makepkg`, and `pacman`
- **Recursive dependency resolution** - Automatically builds and installs AUR dependencies
- **Two fetch modes**:
  - `partial` (default): Maintains a shallow cache with on-demand branch fetching
  - `single`: One-off shallow clone per package (no persistent cache)
- **Security hardened** - Input validation, safe package name handling, and cleanup traps
- **Flexible configuration** - Control build behavior via environment variables

## Installation

### From source

```bash
git clone https://github.com/scoop/aur-lite.git
cd aur-lite
sudo make install
```

To install to a custom location:
```bash
make install PREFIX=~/.local
```

### Direct download

```bash
curl -O https://raw.githubusercontent.com/scoop/aur-lite/main/bin/aur-lite
chmod +x aur-lite
sudo mv aur-lite /usr/local/bin/
```

### Uninstall

```bash
sudo make uninstall
```

## Usage

### Basic usage

Install one or more AUR packages:

```bash
aur-lite -S package_name
aur-lite -S package1 package2 package3
```

### Examples

Install `yay` (an AUR helper):
```bash
aur-lite -S yay
```

Install multiple packages:
```bash
aur-lite -S spotify discord-canary
```

Build without installing:
```bash
NOINSTALL=1 aur-lite -S package_name
```

Skip PGP signature checks:
```bash
MAKEPKG_OPTS="--skippgpcheck" aur-lite -S package_name
```

Use single-clone mode (no cache):
```bash
AUR_MODE=single aur-lite -S package_name
```

Enable verbose output for debugging:
```bash
VERBOSE=1 aur-lite -S package_name
```

## Configuration

aur-lite is configured through environment variables:

| Variable | Default | Description |
|----------|---------|-------------|
| `AUR_MODE` | `partial` | Fetch strategy: `partial` (cached) or `single` (no cache) |
| `AUR_DIR` | `~/.cache/aur-mirror` | Cache directory for partial mode |
| `VERBOSE` | (empty) | Set to `1` to enable debug output |
| `NOCHECK` | (empty) | Set to `1` to skip checkdepends |
| `NODEV` | (empty) | Set to `1` to skip makedepends |
| `NOINSTALL` | (empty) | Set to `1` to build without installing |
| `MAKEPKG_OPTS` | (empty) | Additional options passed to makepkg |

### Configuration examples

Custom cache directory:
```bash
AUR_DIR=/tmp/aur-cache aur-lite -S package_name
```

Skip all optional dependencies:
```bash
NOCHECK=1 NODEV=1 aur-lite -S package_name
```

Pass multiple makepkg options:
```bash
MAKEPKG_OPTS="--skippgpcheck --nocolor" aur-lite -S package_name
```

## How it works

1. **Package resolution**: When you request a package, aur-lite validates the package name and prepares a build directory
2. **Dependency handling**: 
   - Parses the package's `.SRCINFO` for dependencies
   - Installs repository dependencies via `pacman`
   - Recursively builds AUR dependencies first
3. **Fetch strategies**:
   - **Partial mode**: Maintains a shallow git repository cache, fetching only needed branches
   - **Single mode**: Clones each package separately without maintaining a cache
4. **Build process**: Uses `makepkg` to build and install packages with automatic dependency resolution

## Requirements

- Arch Linux or compatible distribution
- `git` - For fetching packages from the GitHub mirror
- `makepkg` - For building packages
- `pacman` - For installing dependencies
- `sudo` access - For installing packages

## Security considerations

- **Input validation**: All package names are validated against Arch Linux naming standards
- **Safe execution**: Package names are sanitized before passing to shell commands
- **Cleanup handling**: Automatic cleanup of temporary files and git worktrees on exit
- **No AUR RPC**: Avoids potential security issues with the AUR API
- **Minimal privileges**: Only uses sudo for `pacman` operations

## Comparison with other AUR helpers

| Feature | aur-lite | yay | paru | aurutils |
|---------|----------|-----|------|----------|
| No RPC dependency | ✓ | ✗ | ✗ | ✓ |
| Minimal dependencies | ✓ | ✗ | ✗ | ✗ |
| Written in | Bash | Go | Rust | Bash |
| Interactive search | ✗ | ✓ | ✓ | ✗ |
| Package updates | ✗ | ✓ | ✓ | ✓ |
| <100 LOC | ✗ | ✗ | ✗ | ✗ |
| Git cache | ✓ | ✓ | ✓ | ✓ |

## Troubleshooting

### Package not found
If a package fails to fetch, ensure:
- The package name is correct (case-sensitive)
- The package exists in the AUR
- You have internet connectivity

### Build failures
For build-related issues:
- Check build dependencies: `VERBOSE=1 aur-lite -S package_name`
- Skip signature checks if needed: `MAKEPKG_OPTS="--skippgpcheck" aur-lite -S package_name`
- Review the package's PKGBUILD for specific requirements

### Permission errors
Ensure you have sudo access for installing packages. For building only:
```bash
NOINSTALL=1 aur-lite -S package_name
```

### Cleanup issues
If git worktrees aren't cleaned properly:
```bash
rm -rf ~/.cache/aur-mirror
```

## Contributing

Contributions are welcome! Please feel free to submit issues and pull requests.

## License

MIT License - see [LICENSE](LICENSE) file for details

## Author

Patrick Lenz (2025)
