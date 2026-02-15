# forge-avatar — Installation

> **For AI agents**: This guide covers installation of forge-avatar. Follow the steps for your deployment mode.

## As part of forge-core

Add as a submodule:

```bash
git submodule add https://github.com/N4M3Z/forge-avatar.git Modules/forge-avatar
```

Then add the module to `defaults.yaml` under the SessionStart event.

## Standalone (Claude Code plugin)

```bash
claude plugin install forge-avatar
```

Or install from a local path during development:

```bash
claude plugin install /path/to/forge-avatar
```

## Configuration

Set `AVATAR_ROOT` if your avatar files aren't at the default path:

```bash
export FORGE_USER_ROOT="$HOME/my-workspace"
```

Default fallback: `$HOME/Data/Vaults/Personal` (hardcoded in script)

### Disable SessionStart hook

Claude Code loads context natively — the SessionStart hook is for other providers. To disable it:

```yaml
# config.yaml
events: []
```
