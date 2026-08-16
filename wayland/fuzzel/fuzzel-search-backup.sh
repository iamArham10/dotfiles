#!/bin/bash

CACHE="$HOME/.cache/fuzzel-files.cache"
CACHE_AGE=300

# Rebuild cache if stale
if [[ ! -f "$CACHE" ]] || (($(date +%s) - $(stat -c %Y "$CACHE") > CACHE_AGE)); then
    find ~/Documents ~/Downloads ~/Desktop ~/Github \
        -type f \( \
        -name "*.pdf" \
        -o -name "*.mp4" \
        -o -name "*.mkv" \
        -o -name "*.avi" \
        -o -name "*.mov" \
        -o -name "*.webm" \
        -o -name "*.mp3" \
        -o -name "*.flac" \
        -o -name "*.ogg" \
        -o -name "*.md" \
        \) 2>/dev/null | sort >"$CACHE"
fi

selected=$(cat "$CACHE" | fzf \
    --prompt "› " \
    --border rounded \
    --color "bg:#1c1c1c,fg:#d4d4d4,hl:#7aa2f7,hl+:#7aa2f7,bg+:#313131,fg+:#ffffff,border:#505050,prompt:#7aa2f7,pointer:#7aa2f7" \
    --preview '
        f={}
        case "$f" in
            *.pdf)
                pdftotext "$f" - 2>/dev/null | head -40 ;;
            *.mp4|*.mkv|*.avi|*.mov|*.webm)
                echo "🎬 $(basename "$f")"
                ffprobe -v quiet -show_entries format=duration,size \
                    -of default=noprint_wrappers=1 "$f" 2>/dev/null ;;
            *.mp3|*.flac|*.ogg)
                echo "🎵 $(basename "$f")"
                ffprobe -v quiet -show_entries format_tags=artist,title \
                    -of default=noprint_wrappers=1 "$f" 2>/dev/null ;;
            *.md)
                head -40 "$f" ;;
            *)
                file "$f" ;;
        esac
    ' \
    --preview-window=down:10:wrap \
    --height=100% \
    --layout=reverse \
    --info=inline)

[[ -z "$selected" ]] && exit 0
setsid xdg-open "$selected" &>/dev/null &
sleep 1
