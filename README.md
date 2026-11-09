# 🛠️ Gitflux v6.2.0 — GitHub CLI Assistant

> A powerful, bilingual GitHub CLI assistant built for Termux — and any Linux environment.

## 🤔 Why Gitflux?

Gitflux combines 35+ Git and GitHub operations into a single, easy-to-remember CLI.
No more typing long Git commands or switching between `git` and `gh`.

Just run `gitflux deploy "fix: login bug"` and you're done. Humanity really looked at hundreds of Git commands and decided, "this is fine." Incredible species.

### Highlights

- 🚀 **One-command deploy** — stage, commit, pull with rebase, and push in a single step.
- 💾 **Backup all your repos** — store local copies in parallel without opening a browser.
- ⏪ **Undo anything** — uncommit, restore files, or reset entirely (with confirmation).
- 🔄 **Daemon mode** — auto-sync your repo every N seconds, with a per-repo lock so it never runs twice.
- 📊 **Stats** — see top contributors, total lines of code, and top file types.
- 🧩 **Full GitHub API support** — manage gists, issues, PRs, releases, and Actions.
- 🌐 **Bilingual** — English by default, Indonesian with `GITFLUX_LANG=id`.
- 🔒 **Strict input validation** — control characters are rejected; branch, tag, and remote names, URLs, and numbers are validated before anything touches Git.
- 🛡️ **Sensitive-file guard** — files like `.env`, `*.pem`, `*.key`, and SSH private keys are flagged before they get committed or uploaded as gists.
- 🖥️ **Adaptive help** — adjusts to your terminal width, uses a pager, and respects `NO_COLOR`.

## 📦 Supported Platforms

| Platform | Status |
| --- | --- |
| Termux (Android) | ✅ Full Support |
| Linux (Ubuntu, Debian, Arch, Fedora) | ✅ Full Support |
| macOS | ✅ Full Support |
| Windows (Git Bash / MSYS2 / Cygwin) | ⚠️ Partial |

## ⚡ Quick Install

One command, and you're ready to go:

```bash
curl -sL https://raw.githubusercontent.com/AhriDeValiente/Gitflux/main/Gitflux.sh -o $PREFIX/bin/gitflux && chmod +x $PREFIX/bin/gitflux
```

Then install the dependencies:

```bash
gitflux setup
```

🎉 Done. Type `gitflux help` to see all available commands.

> **Note:** On Linux/macOS without `$PREFIX`, replace `$PREFIX/bin` with `/usr/local/bin` and use `sudo`.

`gitflux setup` detects your package manager (`pkg`, `apt`, `pacman`, `dnf`, `brew`; `winget`, `scoop`, or `choco` on Windows) and installs `git`, `gh`, `curl`, and `openssh`. It also runs `gh auth login` if you are not authenticated yet.

## 📋 Features Overview

### Core Git

- `deploy`
- `push`
- `pull`
- `sync`
- `status`
- `log`
- `diff`
- `stash`
- `tag`
- `remote`
- `init`

### Branch & Merge

- `branch` — list / create / switch / delete / rename
- `merge`
- `fetch`

### Rewrite History

- `reset` — soft / hard
- `reflog`
- `squash`
- `rebase`
- `cherry-pick`
- `bisect`

### GitHub API

- `repo` — create
- `clone`
- `gist`
- `issue`
- `pr`
- `release`
- `actions`

### Automation

- `backup` — all repos
- `stats`
- `daemon` — auto-sync
- `webhook`

### Setup & Config

- `setup`
- `config` — Git settings
- `undo`
- `keygen`
- `help`

## 📖 Command Reference

> **Heads-up:** `deploy`, `push`, `pull`, and `sync` only operate on the **current** branch. If you pass a branch name that is not the one you're on, Gitflux stops and tells you to switch first (`gitflux branch switch <name>`). They also require a remote named `origin`.

### Core Git

#### `gitflux deploy "message" [branch]`

Stage all files, commit, pull with `--rebase`, then push (`push -u origin <branch>`).

- If no message is given, it uses `deploy: <timestamp>`.
- If the remote branch doesn't exist yet, the pull step is skipped.
- Refuses to run while a rebase or merge is in progress.
- If sensitive files are staged, you are asked to confirm before committing.

**Example:**

```bash
gitflux deploy "fix: login error"
```

#### `gitflux push [branch]`

Push the current branch to `origin` (with upstream tracking).

**Example:**

```bash
gitflux push feature/login
```

#### `gitflux pull [branch]`

Pull the latest changes for the current branch from `origin`.

**Example:**

```bash
gitflux pull main
```

#### `gitflux sync [branch]`

Stage and commit any local changes (`sync: <timestamp>`), pull with `--rebase`, then push.

#### `gitflux status`

Show working tree status, current branch, and the `origin` URL (credentials in URLs are masked).

#### `gitflux log [count]`

Show the last `count` commits (default: 20) as a graph across all branches.

**Example:**

```bash
gitflux log 50
```

#### `gitflux diff [target|--cached|--staged]`

Show changes against `HEAD` (default), a specific commit, or the staging area.

**Examples:**

```bash
gitflux diff HEAD~2
gitflux diff --cached
```

#### `gitflux stash list|save|pop|apply|drop`

Temporarily stash changes (untracked files included).

- `save [message]` — stash changes.
- `pop` — apply and remove the latest stash.
- `apply [n]` — apply `stash@{n}` (default: `0`) and keep it.
- `drop [n]` — delete `stash@{n}` (default: `0`), with confirmation.

**Example:**

```bash
gitflux stash save "WIP: refactor"
```

#### `gitflux tag list|create|push|delete`

Manage tags.

- `create <name> [-m "message"]` — lightweight tag, or annotated when `-m` is given.
- `push` — push all tags to `origin`.
- `delete <name>` — delete the tag locally **and** on `origin` (if it exists there), with confirmation.

**Example:**

```bash
gitflux tag create v1.2.0 -m "Release 1.2.0"
```

#### `gitflux remote show|add|set|rename|delete`

Manage remotes. URLs must start with `https://`, `ssh://`, or `git@host:path`, and may not contain spaces, quotes, or shell metacharacters.

**Examples:**

```bash
gitflux remote add upstream git@github.com:other/repo.git
gitflux remote rename upstream source
```

#### `gitflux init [project]`

Create a new Git repo in a new folder (default: `my-project`) with a `README.md`, a `.gitignore` (`node_modules/`, `.env`, `.env.*`, `*.pem`, `*.key`), and a first commit.

If the commit fails, check your identity: `gitflux config set user.name "..."` and `gitflux config set user.email "..."`.

**Example:**

```bash
gitflux init my-awesome-project
```

### Branch & Merge

#### `gitflux branch list`

List all local and remote branches.

#### `gitflux branch create <name>`

Create and switch to a new branch.

**Example:**

```bash
gitflux branch create feat/oauth
```

#### `gitflux branch switch <name>`

Switch to an existing branch.

#### `gitflux branch delete <name>`

Delete a branch. Uses the safe `-d`, so unmerged branches are refused.

#### `gitflux branch rename <old> <new>`

Rename a branch.

#### `gitflux merge <branch> [--no-ff|--squash]`

Merge a branch into the current branch. Optionally force a merge commit (`--no-ff`) or squash the changes (`--squash`).

#### `gitflux fetch`

Fetch all remotes and prune deleted remote branches.

### Rewrite History

#### `gitflux reset soft|hard [target]`

Reset `HEAD` to a specific commit.

- `soft` — keeps your changes staged. Defaults to `HEAD~1`.
- `hard` — discards changes. **Requires an explicit target** (e.g. `HEAD~1`), shows the commit you are resetting to, and asks for confirmation.

#### `gitflux reflog`

Show the last 20 `HEAD` reference logs. Great for recovering lost commits.

#### `gitflux squash [count]`

Squash the last N commits into one (default: 2). N must be at least 2 and smaller than the total number of commits, and your working tree must be clean. The new commit message lists the squashed commit subjects. If the commit fails, the reset is rolled back.

#### `gitflux rebase [branch]`

Rebase the current branch onto another branch. Defaults to `main`, or `master` if `main` doesn't exist.

#### `gitflux cherry-pick <commit>`

Apply a specific commit to the current branch.

#### `gitflux bisect start|good|bad|reset`

Binary search for a buggy commit. `good` and `bad` accept an optional commit (default: `HEAD`). Tiny archaeological dig through your own mistakes. A timeless Git tradition.

### GitHub API

> Commands in this section (and `backup`) require the GitHub CLI (`gh`) and an authenticated session. If you aren't logged in, Gitflux tells you to run `gh auth login`.

#### `gitflux repo <name> [public|private|internal]`

Create a new GitHub repo and clone it locally. Visibility defaults to **private**.

#### `gitflux clone <user/repo> [--depth N] [--branch name]`

Clone a GitHub repo, optionally shallow and/or a specific branch.

**Example:**

```bash
gitflux clone AhriDeValiente/Gitflux --depth 1
```

#### `gitflux gist list|create|edit|delete`

Manage GitHub Gists.

- `create <file>` — create a gist from a file. Files that look sensitive (`.env`, `*.pem`, `*.key`, SSH keys, `credentials*`, `*secret*`, …) are refused.
- `edit <id>` / `delete <id>` — delete asks for confirmation.

#### `gitflux issue list|create|close|view`

Manage Issues (`create <title>`, `close <number>`, `view <number>`).

#### `gitflux pr list|create|merge|checkout|review`

Manage Pull Requests (`create <title>`, and `merge`/`checkout`/`review` take a PR number).

#### `gitflux release list|create|delete`

Manage Releases (`create <tag>`, `delete <tag>`).

#### `gitflux actions list|watch|trigger`

Manage GitHub Actions: `list` recent runs, `watch <run-id>`, or `trigger <workflow>`.

### Automation

#### `gitflux backup [folder]`

Back up all your GitHub repos locally. Runs up to 4 jobs in parallel. New repos are cloned; existing ones are updated with `fetch` and `pull --ff-only`. Default folder: `~/gitflux-backups`.

#### `gitflux stats`

Show contribution stats: top 10 contributors, total lines of code (text files only), and the top 5 file extensions.

#### `gitflux daemon start|stop|status|restart [seconds]`

Auto-sync the current repo every N seconds (default: 600) using the same logic as `gitflux sync`.

- Each repo gets its own lock directory (`daemon-<hash>.lock`) inside `$XDG_RUNTIME_DIR`, or `~/.cache/gitflux` if that isn't set. It stores the PID, and stale locks from crashes are cleaned up automatically.
- Runs **non-interactively**: if sensitive files are staged, the sync is cancelled and the files are unstaged instead of asking.
- Runs in the **foreground**. To keep it running in the background:

```bash
nohup gitflux daemon start 300 >/dev/null 2>&1 &
```

Then use `gitflux daemon status` or `gitflux daemon stop` from the same repo.

#### `gitflux webhook`

Send a test ping (JSON with event, tool, and timestamp) to your `WEBHOOK_URL`. Only `https://` URLs are accepted. Retries up to 3 times with increasing delays.

### Setup & Config

#### `gitflux setup`

Auto-detect the package manager and install all dependencies (`git`, `gh`, `curl`, `openssh`). Also runs `gh auth login` if not authenticated.

#### `gitflux config show|set|remote`

View or modify Git config settings.

- `show` — list the Git config (credentials in URLs are masked).
- `set <key> <value> [--local]` — set a value globally, or per-repo with `--local`. Only these keys are allowed: `user.name`, `user.email`, `user.signingkey`, `init.defaultBranch`, `pull.rebase`, `push.autoSetupRemote`, `core.autocrlf`, `commit.gpgsign`, `core.editor`, `merge.tool`, `diff.tool`.
- `remote <url>` — set (or add) the `origin` remote.

**Examples:**

```bash
gitflux config set user.email you@example.com
gitflux config set pull.rebase true --local
gitflux config remote https://github.com/you/repo.git
```

#### `gitflux undo commit|file|hard`

Undo changes safely.

- `commit` — soft reset of the last commit, keeps files staged.
- `file <name>` — restore a single file.
- `hard` — discard all changes back to `HEAD` (requires confirmation).

#### `gitflux keygen [email] [--force]`

Generate a new ED25519 SSH key for GitHub. Saves to `~/.ssh/id_ed25519_gitflux` and prints the public key. If the key already exists, Gitflux won't overwrite it unless you pass `--force`, in which case the old key is backed up first.

#### `gitflux help [section]`

Show the command reference in your terminal. The layout adapts to your terminal width and opens in a pager (`less`) when running interactively.

Sections: `basic`, `branch`, `history`, `github`, `auto`, `setup`.

**Example:**

```bash
gitflux help github
```

## 🛡️ Safety & Validation

- **Strict validation:** control characters are rejected in free text; branch and tag names are checked with `git check-ref-format`; commits/revisions must exist; remote names, repo names, IDs, and numbers must match strict patterns. Normal punctuation (including `$`, quotes, and `;`) is fine in commit messages.
- **Sensitive-file guard:** staged files such as `.env`, `*.pem`, `*.key`, `*.p12`, `.netrc`, `.npmrc`, SSH keys, `credentials*`, and `*secret*` trigger a warning and a confirmation prompt.
- **Destructive actions ask first:** hard reset, `undo hard`, stash drop, tag delete, and gist delete all require confirmation.
- **No force-push:** Gitflux never force-pushes.
- **Credentials stay hidden:** remote URLs shown by `status`, `remote show`, and `config show` are masked.

## 🌐 Language / Bahasa

Gitflux speaks English by default.

To switch to Indonesian, set the environment variable:

```bash
export GITFLUX_LANG=id
```

Add that line to your `~/.bashrc` to make it permanent. Because typing the same export command forever is apparently how humans build character.

## ⚙️ Configuration

| Variable | Description | Default |
| --- | --- | --- |
| `GITFLUX_LANG` | Language (`en` or `id`) | `en` |
| `WEBHOOK_URL` | Webhook URL for `gitflux webhook` (must be `https://`) | — |
| `GITFLUX_NOPAGER` | Set to any value to disable the `less` pager in `help` | — |
| `NO_COLOR` | Set to any value to disable colors ([no-color.org](https://no-color.org)) | — |
| `XDG_RUNTIME_DIR` | Where daemon lock directories are stored | `~/.cache/gitflux` |

## 🆚 Comparison with `gh` CLI

| Feature | Gitflux | `gh` CLI |
| --- | --- | --- |
| One-command deploy | ✅ | ❌ |
| Backup all repos | ✅ | ❌ |
| Undo (commit / file / hard) | ✅ | ❌ |
| Squash, Rebase, Cherry-pick, Bisect, Reflog | ✅ | ❌ |
| Auto-sync (daemon) | ✅ | ❌ |
| Contribution stats | ✅ | ❌ |
| SSH key generator | ✅ | ❌ |
| Sensitive-file guard | ✅ | ❌ |
| Bilingual (EN / ID) | ✅ | ❌ |
| Input validation & sanitization | ✅ | ❌ |
| Gist / Issue / PR / Release / Actions | ✅ | ✅ |
| Repo create / Clone | ✅ | ✅ |

> **Total:** 35+ features — more powerful than `gh` CLI while staying lightweight.

## 🛠️ Troubleshooting

### `command not found` after install

Make sure `$PREFIX/bin` (or `/usr/local/bin`) is in your `PATH`. Run `hash -r` or restart Termux.

### `Command 'gh' not found` / `Command 'git' not found`

Run:

```bash
gitflux setup
```

### `Not logged into GitHub`

Commands such as `repo`, `clone`, `gist`, `issue`, `pr`, `release`, `actions`, and `backup` need an authenticated `gh`:

```bash
gh auth login
```

### `Not a Git repository`

You're not inside a Git repo. Navigate to one, or run:

```bash
gitflux init my-project
```

### `Remote 'origin' is not set`

`deploy`, `push`, `pull`, and `sync` need an `origin` remote:

```bash
gitflux remote add origin <url>
```

### `Branch 'x' is not the current branch`

`deploy`, `push`, `pull`, and `sync` only work on the branch you're on. Switch first:

```bash
gitflux branch switch x
```

### `A rebase/merge is in progress`

Finish or abort it first (`git rebase --continue` / `--abort`, or `git merge --abort`), then run the command again.

### Deploy fails with merge conflicts

Gitflux won't force-push. Resolve conflicts manually, then run `deploy` again. Because Git believes suffering builds wisdom.

### `Sensitive files detected in staging`

Gitflux found something that looks like a secret (e.g. `.env`, `*.pem`, a private key). Answer `n` at the prompt, add the file to `.gitignore`, and unstage it. In daemon mode the sync is cancelled automatically.

### `Working tree is not clean`

`squash` needs a clean working tree. Commit or stash your changes first:

```bash
gitflux stash save "WIP"
```

### `Invalid characters detected in ...`

Your input contains control characters (for example a pasted escape sequence). Retype the value and try again.

### Daemon won't start

A previous daemon may still be running. Check and stop it from the same repo:

```bash
gitflux daemon status
gitflux daemon stop
```

Stale locks from crashes are cleaned up automatically on the next start.

## 🤝 Contributing

Pull requests are welcome!

If you have an idea for a new feature or found a bug, open an issue on GitHub.

## 📄 License

MIT © 2026 AhriDeValiente

## 🧑‍💻 Developer

**AhriDeValiente**  
GitHub: `@AhriDeValiente`

> “Good tools make good developers. Build them, share them, improve them.”
