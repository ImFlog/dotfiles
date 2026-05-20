#!/usr/bin/env bash
# Claude Code status line — mirrors a Starship-style prompt

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
model=$(echo "$input" | jq -r '.model.display_name // empty')
used=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // 0')
reset=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // 0')
ctx_used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Shorten home directory to ~
home="$HOME"
short_cwd="${cwd/#$home/\~}"

# Git branch (skip optional lock)
branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)

# Build prompt parts
parts=()

# Directory
parts+=("$(printf '\033[34m%s\033[0m' "$short_cwd")")

# Git branch
if [ -n "$branch" ]; then
  parts+=("$(printf '\033[33m(%s)\033[0m' "$branch")")
fi

# Model
if [ -n "$model" ]; then
  parts+=("$(printf '\033[36m%s\033[0m' "$model")")
fi

# Context window usage
if [ -n "$ctx_used" ]; then
  ctx_int=$(printf '%.0f' "$ctx_used")

  if [ "$ctx_int" -ge 80 ]; then
    ctx_color='\033[31m'
  elif [ "$ctx_int" -ge 50 ]; then
    ctx_color='\033[33m'
  else
    ctx_color='\033[32m'
  fi
  parts+=("$(printf "${ctx_color}ctx:%d%%\033[0m" "$ctx_int")")
fi

# Rate limit usage
if [ -n "$used" ]; then
  used_int=$(printf '%.0f' "$used")

  remaining=$(( reset - $(date +%s) ))
  reset_hours=$(( remaining / 3600 ))
  reset_mins=$(( (remaining % 3600) / 60 ))

  if [ "$used_int" -ge 80 ]; then
    color='\033[31m'
  elif [ "$used_int" -ge 50 ]; then
    color='\033[33m'
  else
    color='\033[32m'
  fi
  parts+=("$(printf "${color}usage:%d%% (reset in %d:%d)\033[0m" "$used_int" "$reset_hours" "$reset_mins" )")
fi

# Join with separator
printf '%s' "${parts[0]}"
for part in "${parts[@]:1}"; do
  printf ' | %s' "$part"
done
printf '\n'
