
# Kolatr: fastfetch (Shell Message) (shell-message)

Displays system information specific to Kolatr when opening a new shell via fastfetch. See tests for base image compatibility. Disable with KOLATR_DISABLE_SHELL_MESSAGE=true.

## Example Usage

```json
"features": {
    "ghcr.io/kolatr-dev/devcontainer-features/shell-message:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| service-checks | Services to check in the format label:port[:colour][,label:port[:colour]] | string | - |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/kolatr-dev/devcontainer-features/blob/main/src/shell-message/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
