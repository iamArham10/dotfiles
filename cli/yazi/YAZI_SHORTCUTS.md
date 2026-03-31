## Custom Yazi shortcuts and plugins

All paths are relative to your Yazi config in `~/.config/yazi`.

### Pane layout / resizing (`toggle-pane.yazi`)

These operate on the 3 columns defined by `ratio = [1, 4, 3]` in `yazi.toml`:
- parent (left), current (middle), preview (right).

- **`u`**: toggle preview pane (right) visibility  
  - Plugin: `toggle-pane min-preview`  
  - Behavior: hides/shows the preview while keeping your original ratios.

- **`U`**: maximize / restore preview pane  
  - Plugin: `toggle-pane max-preview`  
  - Behavior: toggles between normal layout and preview taking the full width.

- **`g` → `P`**: toggle parent pane (left) visibility  
  - Plugin: `toggle-pane min-parent`  
  - Behavior: hide/show the parent directory column.

- **`g` → `R`**: maximize / restore parent pane  
  - Plugin: `toggle-pane max-parent`  
  - Behavior: toggles between normal layout and parent pane taking the full width.

- **`g` → `C`**: toggle current pane (middle) visibility  
  - Plugin: `toggle-pane min-current`  
  - Behavior: hide/show the main file list column.

- **`g` → `M`**: maximize / restore current pane  
  - Plugin: `toggle-pane max-current`  
  - Behavior: toggles between normal layout and current pane taking the full width.

### File navigation / opening

- **`l`**: smart enter / open (`smart-enter.yazi`)  
  - On a directory: behaves like normal `enter` (cd into it).  
  - On a file: runs `open --hovered` to open the file using your `yazi.toml` openers.

### Filtering and searching

- **`F`**: smart filter (`smart-filter.yazi`)  
  - Incremental filtering as you type.  
  - If only one directory matches, it auto-enters it.  
  - If a single file is focused and you press Enter, it opens the file.

### Yank / paste behavior

- **`p`**: smart paste (`smart-paste.yazi`)  
  - If cursor is on a directory: paste yanked files *into that directory*.  
  - If cursor is on a file: paste into the current working directory.  
  - Replaces plain `p` paste with smarter behavior.

### Preview zoom (`zoom.yazi`)

- **`+`**: zoom in preview image  
  - Plugin: `zoom 1`  
  - Works on image previews; zooms in step by step (bounded by `preview.max_width` / `max_height`).

- **`-`**: zoom out preview image  
  - Plugin: `zoom -1`  
  - Works on image previews; zooms out step by step.

### Git status (`git.yazi`)

- Plugin is configured in `init.lua` and `yazi.toml` and has **no dedicated keybinding**.  
- Behavior: adds Git status indicators (modified / added / untracked / etc.) into the file list linemode.  
- It runs automatically whenever you’re inside a Git repository.

### Existing custom bindings you already had

- **`T`**: open a blocking shell here  
  - Command: `shell "$SHELL" --block --confirm`

- **`C`**: copy hovered / selected path(s) to Wayland clipboard  
  - Command: `shell 'for path in "$@"; do echo -n "$path" | wl-copy; done' --confirm`

