#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Compatibility entrypoint for callers that previously created J/K bindings
# dynamically. The Lua config now declares those bindings statically.

set -euo pipefail

hyprctl reload
