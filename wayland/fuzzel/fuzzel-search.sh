#!/bin/bash
CACHE="$HOME/.cache/fuzzel-files.cache"
CACHE_AGE=300

if [[ ! -f "$CACHE" ]] || (($(date +%s) - $(stat -c %Y "$CACHE") > CACHE_AGE)); then
    find ~/Documents ~/Downloads ~/Desktop ~/Github \
        -type d \( \
        -name "node_modules" \
        -o -name ".git" \
        -o -name ".svn" \
        -o -name ".hg" \
        -o -name "__pycache__" \
        -o -name ".pytest_cache" \
        -o -name ".mypy_cache" \
        -o -name ".ruff_cache" \
        -o -name ".cache" \
        -o -name ".tmp" \
        -o -name "tmp" \
        -o -name "temp" \
        -o -name "dist" \
        -o -name "build" \
        -o -name "out" \
        -o -name ".next" \
        -o -name ".nuxt" \
        -o -name ".svelte-kit" \
        -o -name ".output" \
        -o -name "vendor" \
        -o -name "venv" \
        -o -name ".venv" \
        -o -name "env" \
        -o -name ".env" \
        -o -name "virtualenv" \
        -o -name "target" \
        -o -name ".cargo" \
        -o -name ".gradle" \
        -o -name ".m2" \
        -o -name "bin" \
        -o -name "obj" \
        -o -name ".idea" \
        -o -name ".vscode" \
        -o -name "coverage" \
        -o -name ".nyc_output" \
        -o -name "logs" \
        -o -name ".log" \
        \) -prune -o \
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
        \) -print 2>/dev/null | sort >"$CACHE"
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
