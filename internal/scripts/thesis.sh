#!/bin/sh

set -eu

mode=${1:-render}
if [ "$#" -gt 0 ]; then
  shift
fi

language=$(sed -n \
  's/^[[:space:]]*\\newcommand{\\HCWLanguage}{\([^}]*\)}.*/\1/p' \
  setup.tex | head -n 1)

case "$language" in
  de|en) ;;
  *)
    echo "Fehler: HCWLanguage in setup.tex muss de oder en sein." >&2
    exit 1
    ;;
esac

case "$mode" in
  render)
    exec quarto render --profile "$language" "$@"
    ;;
  preview)
    exec hcw-preview --profile "$language" "$@"
    ;;
  *)
    echo "Fehler: Unbekannter Modus '$mode'. Verwenden Sie render oder preview." >&2
    exit 1
    ;;
esac
