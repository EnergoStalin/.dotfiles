# Repository instructions

- Do not create or edit README files; they interfere with the install script's assumptions.
- Preserve implementation assumptions, configuration rationale, and operational caveats in concise comments next to the relevant code or configuration instead.

## Installation contract (`install.sh`)

- Run the installer from the repository root: package paths and `.local/bin` are relative to the current directory.
- Top-level package directories are deployment payloads, not project/documentation directories. Their contents mirror paths relative to the installation target. Do not add incidental files inside them.
- `installconfig` uses GNU Stow to link a package into `${XDG_CONFIG_HOME:-$HOME/.config}`; `installhome` links into `$HOME`. Preserve the directory layout expected at those targets.
- `installroot` recursively copies the entire package directory into `/` with sudo, preserving modes and timestamps. For example, `xray/etc/...` becomes `/etc/...`. This path has no Stow ignore filtering: extra files, including documentation, would also be copied into the filesystem root.
- Package-gated installs use `pacman -Qi` with the directory/package name. Executable-gated installs use `which`. Adding a directory alone does not install it; keep the explicit installer registration and its gate consistent with the intended package or executable.
- Optional `prepare.sh` and `post.sh` hooks run before and after deployment, respectively, with the package directory as their working directory. They are invoked as `sh <hook>.sh <package> <target>`: `$1` is the package name and `$2` is the target directory. A hook's shebang does not select its interpreter; account for the environment's `sh` when editing hooks.
- Stow's configured exclusions live in `stow/.stow-global-ignore`; they exclude hooks, `packages.txt`, Stow metadata, Git metadata, and `*.template` files. These exclusions do not apply to root-copy installs and do not exclude arbitrary new documentation or instruction files.
- Installs run concurrently in background jobs. Do not assume ordering between packages or introduce cross-package dependencies without explicit synchronization. Hooks should tolerate repeated runs.
- The installer uses `set -u`, not fail-fast error handling. Do not assume a failed prepare hook or deployment prevents the post hook from running, or that the final wait reliably reports every package's failure.
- Do not run the full installer as a validation step: it changes live configuration, uses sudo, and can restart services. Prefer targeted syntax checks, mocked hook tests, and isolated validation.
