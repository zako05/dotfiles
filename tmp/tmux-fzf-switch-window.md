# Tmux Fast Window Switching

This conversation explores methods for switching between many tmux windows (more than 9) efficiently, specifically focusing on an `fzf` integration.

## User Question
**tmux - how to switching fast between the windows within a session if there is more like 9 of them so "prefix + number" isn't sufficient**

## Assistant Response
When you have more than 9 windows in a `tmux` session, you can use these built-in methods and custom configurations to switch between them quickly:

### 1. Interactive List (Tree Mode)
Press **`prefix + w`**. 
This opens an interactive, searchable list of all windows and panes across all sessions.
*   **Navigate:** Use arrow keys or `j`/`k` (Vim keys).
*   **Search:** Press `/` to search for a specific window name.
*   **Select:** Press `Enter` to switch to the highlighted window.

### 2. Prompt for Index
Press **`prefix + '`** (apostrophe).
`tmux` will open a prompt asking for the window index. You can type any multi-digit number (e.g., `12`) and press `Enter`.

### 3. Find Window by Name
Press **`prefix + f`**.
Type a part of the window's name or content. `tmux` will show a list of matches; if there's only one match, it switches immediately.

### 4. Previous/Next and Last
*   **`prefix + n`**: Next window.
*   **`prefix + p`**: Previous window.
*   **`prefix + l`**: Jump back to the **last** active window (excellent for toggling between two specific windows).

---

### 5. Custom "Pro" Setup (Recommended)
If you find yourself frequently dealing with 10+ windows, adding a fuzzy finder like `fzf` to your `.tmux.conf` is the fastest method:

**Fuzzy Switcher Script:**
Add this bind to your `~/.tmux.conf` (requires `fzf` installed):
```bash
bind-key -r f run-shell "tmux list-windows -F '#I: #W' | fzf-tmux -p | cut -d: -f1 | xargs tmux select-window -t"
```
Now, **`prefix + f`** will open a small popup where you can fuzzy-search through all window names and jump to them instantly.

### 6. Alt + Number Bindings
You can bind `M-0` through `M-9` (Alt + Number) to switch windows directly without needing the prefix, but for >9 windows, some users bind `Alt + j/k` to cycle windows:
```bash
# Cycle windows with Alt + hjkl (no prefix needed)
bind -n M-h previous-window
bind -n M-l next-window
```

## Follow-up
**User:** The method with fzf is realy cool. Please check it out if it's not already implemented.

## Investigation Result
The `fzf` window switching method is **not currently implemented** in this repository. 

I've searched through the configuration files, documentation (`README.md`, `IDE.md`), and utility scripts. While `fzf` is used in `scripts/workspace-run.sh` for selecting yarn workspaces, there is no existing `tmux` configuration or script for window navigation.

### Proposed Implementation
If you'd like to add this, you can implement it by adding the following to your `~/.tmux.conf`:

```bash
# Add to ~/.tmux.conf
bind-key -r f run-shell "tmux list-windows -F '#I: #W' | fzf-tmux -p | cut -d: -f1 | xargs tmux select-window -t"
```

**How it works:**
1.  **`list-windows`**: Gets the list of current windows with their index (`#I`) and name (`#W`).
2.  **`fzf-tmux -p`**: Opens that list in a `tmux` popup (requires `tmux` 3.2+) using `fzf`.
3.  **`select-window`**: Switches to the index of the window you select.
