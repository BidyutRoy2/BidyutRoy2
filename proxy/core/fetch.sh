#!/bin/bash
mkdir -p sources
while read -r url; do
  [[ -z "$url" ]] && continue

  if [[ "$url" == *.git ]]; then
    name=$(basename "$url" .git)
    if [ -d "sources/$name/.git" ]; then
      git -C sources/$name pull
    else
      git clone "$url" sources/$name
    fi
  elif [[ "$url" == *"/tree/"* ]]; then
    repo=$(echo "$url" | cut -d/ -f4,5)
    branch=$(echo "$url" | sed 's|.*tree/||' | cut -d/ -f1)
    path=$(echo "$url" | sed "s|.*tree/$branch/||")
    api="https://api.github.com/repos/$repo/contents/$path?ref=$branch"

    mkdir -p sources/raw
    curl -s "$api" | grep download_url | cut -d '"' -f4 | while read f; do
      curl -s "$f" -o "sources/raw/$(basename "$f")"
    done
  fi
done < repos.txt

