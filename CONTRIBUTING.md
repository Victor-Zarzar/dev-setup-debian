# Contributing to Dev Setup Debian

Thanks for your interest in contributing to Dev Setup Debian.

Dev Setup Debian helps developers set up their development environment on Debian-based systems.

## Ways to contribute

- Report bugs
- Propose new cleanup commands
- Improve scripts and compatibility
- Improve documentation (README / examples / translations)

## Before you start

- Check existing issues and pull requests first.
- Keep changes focused and small.
- For cleanup behavior changes, include clear reproduction and verification steps.
- Prioritize safety over aggressive cleanup.

## Development setup

1. Fork and clone the repository.
2. Create a branch:

   - `feat/<short-name>` for new features
   - `fix/<short-name>` for bug fixes
   - `docs/<short-name>` for documentation

3. Make your changes.
4. Test affected scripts on a Debian-based system whenever possible.

## Pull request checklist

- [ ] Scope is focused and related to one topic.
- [ ] Scripts run without syntax errors (`bash -n <script>.sh` where applicable).
- [ ] Documentation is updated if behavior or commands changed.
- [ ] Cleanup commands were tested safely.
- [ ] No unrelated refactors or formatting-only changes.
- [ ] PR description includes what changed, why, and how it was tested.

## Commit message examples

- `feat: add npm cache cleanup`
- `feat: add docker cleanup command`
- `fix: prevent errors when snap is not installed`
- `fix: handle missing apt cache gracefully`
- `docs: update installation instructions`

## Coding guidelines

- Prefer simple and readable shell scripts.
- Keep cleanup operations predictable and safe.
- Always verify that files or directories exist before removing them.
- Avoid destructive defaults when uncertainty exists.
- Gracefully handle missing packages or commands.
- Follow the existing style used throughout the repository.

## Reporting bugs (suggested template)

Please include:

- Debian version (or Debian-based distribution)
- Desktop environment (if relevant)
- Shell (`bash`/`zsh`) and version
- Exact command run
- Expected vs actual behavior
- Relevant terminal output

## Need help?

Open an issue and provide as much context as possible. We appreciate all contributions.
