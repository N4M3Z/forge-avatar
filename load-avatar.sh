#!/usr/bin/env bash
# Shim — delegates to hooks/session-start.sh (canonical location).
exec bash "$(dirname "$0")/hooks/session-start.sh"
