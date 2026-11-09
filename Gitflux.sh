#!/usr/bin/env bash
# ============================================================
# Gitflux v6.2.0 — Cross-Platform GitHub CLI Assistant (Stable)
# Developer By: AhriDeValiente
# Bilingual (EN / ID) — set GITFLUX_LANG=id for Indonesian
# Adaptive terminal-width help + pager + NO_COLOR support
# ============================================================
set -euo pipefail
GITFLUX_LANG="${GITFLUX_LANG:-en}"
VERSION="6.2.0"

# ==================== BILINGUAL MESSAGES ====================
if [ "$GITFLUX_LANG" = "id" ]; then
T_DEPENDENCIES_OK="Semua dependensi terpenuhi."
T_DEPENDENCIES_MISSING="Dependensi berikut belum terinstal:"
T_RUN_SETUP="Jalankan: gitflux setup"
T_NOT_GIT_REPO="Bukan repositori Git. Jalankan 'git init' atau clone repo dulu."
T_HELP_LINE="Ketik 'gitflux help' untuk daftar perintah."
T_FAIL_UNKNOWN="Perintah tidak dikenal:"
T_CONFIRM="Apakah Anda yakin?"
T_CANCEL="Dibatalkan."
T_DONE="Selesai."
T_INVALID_INPUT="Input tidak valid."
T_YES_NO="[y/N]"
T_DETACHED_HEAD="Detached HEAD atau repo kosong. Tidak dapat melanjutkan."
T_COMMIT_CANCELLED="Commit dibatalkan."
T_REMOTE_NOT_SET="tidak disetel"
T_DEPLOY_START="Deploy ke branch"
T_FILE_STAGED="File di-stage."
T_FILE_STAGE_FAILED="Gagal stage file."
T_NO_CHANGES="Tidak ada perubahan, commit dilewati."
T_COMMIT_OK="Commit:"
T_COMMIT_FAILED="Gagal commit."
T_PULL_INFO="Menarik perubahan terbaru..."
T_PULL_OK="Pull berhasil."
T_PULL_SKIP="Pull dilewati."
T_PUSH_INFO="Mendorong ke remote..."
T_PUSH_OK="Push berhasil."
T_PUSH_FAILED="Push gagal."
T_DEPLOY_DONE="Deploy selesai."
T_SYNC_OK="Sync selesai."
T_PUSH_SUCCESS="Push ke '%s' berhasil."
T_PUSH_ERROR="Push gagal."
T_PULL_SUCCESS="Pull dari '%s' berhasil."
T_PULL_ERROR="Pull gagal."
T_STASH_SAVED="Perubahan disimpan."
T_STASH_POPPED="Stash dikeluarkan."
T_STASH_APPLIED="Stash diterapkan."
T_STASH_DROPPED="Stash dihapus."
T_USAGE_STASH="Gunakan: list, save [pesan], pop, apply, drop"
T_TAG_CREATED="Tag '%s' dibuat."
T_TAG_DELETED="Tag '%s' dihapus."
T_TAG_PUSHED="Tag di-push."
T_USAGE_TAG="Gunakan: list, create <nama> [-m pesan], push, delete <nama>"
T_TAG_NAME_REQUIRED="Nama tag diperlukan."
T_TAG_INVALID_NAME="Nama tag mengandung karakter tidak valid."
T_REMOTE_ADDED="Remote '%s' ditambahkan."
T_REMOTE_UPDATED="Remote '%s' diperbarui."
T_REMOTE_DELETED="Remote '%s' dihapus."
T_REMOTE_RENAMED="Remote '%s' diubah menjadi '%s'."
T_USAGE_REMOTE="Gunakan: show, add <nama> <url>, set <nama> <url>, rename <lama> <baru>, delete <nama>"
T_REMOTE_NAME_REQUIRED="Nama remote diperlukan."
T_REPO_INIT="Repo '%s' dibuat. Tambahkan remote: gitflux remote add origin <url>"
T_FOLDER_EXISTS="Folder '%s' sudah ada."
T_CREATE_FOLDER_FAIL="Gagal membuat folder."
T_BRANCH_CREATED="Branch '%s' dibuat."
T_BRANCH_SWITCHED="Pindah ke '%s'."
T_BRANCH_DELETED="Branch '%s' dihapus."
T_BRANCH_DELETE_FAIL="Gagal menghapus branch."
T_BRANCH_RENAMED="Branch '%s' diubah menjadi '%s'."
T_USAGE_BRANCH="Gunakan: list, create <nama>, switch <nama>, delete <nama>, rename <lama> <baru>"
T_MERGE_OK="Merge berhasil."
T_MERGE_CONFLICT="Merge konflik. Selesaikan secara manual."
T_USAGE_MERGE="Gunakan: gitflux merge <branch> [--no-ff|--squash]"
T_FETCH_OK="Fetch selesai."
T_RESET_SOFT="Reset soft ke '%s'."
T_RESET_HARD="Reset hard ke '%s'."
T_USAGE_RESET="Gunakan: gitflux reset [soft|hard] [target]"
T_RESET_HARD_CONFIRM="Reset HARD akan menghapus perubahan. Yakin?"
T_SQUASH_DONE="Squash selesai."
T_SQUASH_INVALID_N="Jumlah commit harus bilangan bulat minimal 2."
T_SQUASH_TOO_LARGE="Jumlah commit melebihi total commit yang ada."
T_REBASE_DONE="Rebase selesai."
T_REBASE_CONFLICT="Rebase konflik."
T_CHERRY_PICK_DONE="Commit di-cherry-pick."
T_USAGE_CHERRY_PICK="Gunakan: gitflux cherry-pick <commit>"
T_BISECT_START="Bisect dimulai."
T_BISECT_GOOD="Commit ditandai good."
T_BISECT_BAD="Commit ditandai bad."
T_BISECT_RESET="Bisect direset."
T_USAGE_BISECT="Gunakan: start, good, bad, reset"
T_REPO_CREATE_OK="Repo GitHub '%s' dibuat."
T_REPO_CREATE_FAIL="Gagal membuat repo."
T_CLONE_OK="Clone selesai."
T_CLONE_FAIL="Clone gagal."
T_GIST_CREATED="Gist dibuat."
T_GIST_EDITED="Gist diedit."
T_GIST_DELETED="Gist dihapus."
T_ISSUE_CREATED="Issue dibuat."
T_ISSUE_CLOSED="Issue #%s ditutup."
T_PR_CREATED="PR dibuat."
T_PR_MERGED="PR #%s di-merge."
T_PR_CHECKOUT="Checkout PR #%s."
T_PR_REVIEWED="Review PR #%s."
T_RELEASE_CREATED="Release '%s' dibuat."
T_RELEASE_DELETED="Release '%s' dihapus."
T_ACTIONS_WATCH="Memantau run #%s."
T_ACTIONS_TRIGGER="Workflow '%s' di-trigger."
T_USAGE_REPO="Gunakan: gitflux repo <nama> [public|private]"
T_USAGE_CLONE="Gunakan: gitflux clone <user/repo> [--depth N] [--branch nama]"
T_USAGE_GIST="Gunakan: list, create <file>, edit <id>, delete <id>"
T_USAGE_ISSUE="Gunakan: list, create <judul>, close <nomor>, view <nomor>"
T_USAGE_PR="Gunakan: list, create <judul>, merge <nomor>, checkout <nomor>, review <nomor>"
T_USAGE_RELEASE="Gunakan: list, create <tag>, delete <tag>"
T_USAGE_ACTIONS="Gunakan: list, watch <id>, trigger <workflow>"
T_BACKUP_START="Mem-backup semua repo ke '%s'..."
T_BACKUP_DONE="Backup selesai."
T_STATS_COMMIT_BY="Commit oleh %s:"
T_STATS_LINES="Total baris kode:"
T_STATS_LANG="Bahasa dominan:"
T_DAEMON_START="Daemon Gitflux berjalan (sinkronisasi tiap %s detik)..."
T_DAEMON_ALREADY="Daemon sudah berjalan."
T_DAEMON_STOPPED="Daemon dihentikan."
T_DAEMON_NOT_RUNNING="Daemon tidak berjalan."
T_DAEMON_STATUS="Daemon berjalan dengan PID %s"
T_USAGE_DAEMON="Gunakan: start [detik], stop, status, restart [detik]"
T_WEBHOOK_OK="Webhook terkirim."
T_WEBHOOK_FAIL="Webhook gagal."
T_WEBHOOK_RETRY="Mencoba ulang... (%s/%s)"
T_WEBHOOK_URL_NOT_SET="Setel WEBHOOK_URL terlebih dahulu."
T_KEYGEN_OK="Kunci dibuat: %s"
T_KEYGEN_FAIL="Gagal membuat kunci."
T_KEYGEN_BACKUP="Kunci lama di-backup ke: %s"
T_CONFIG_SET="%s disetel ke %s."
T_CONFIG_SET_FAIL="Gagal menyetel %s."
T_CONFIG_REMOTE_OK="Remote dikonfigurasi."
T_USAGE_CONFIG="Gunakan: show, set <key> <value> [--local], remote <url>"
T_UNDO_COMMIT="Commit terakhir dibatalkan (file aman)."
T_UNDO_FILE="File '%s' dikembalikan."
T_UNDO_HARD="Semua perubahan dibuang."
T_USAGE_UNDO="Gunakan: commit, file <nama>, hard"
T_UNDO_HARD_CONFIRM="Ini akan menghapus SEMUA perubahan. Yakin?"
T_SETUP_DONE="Setup selesai. Coba: gitflux help"
T_ALREADY_LOGIN="Sudah login ke GitHub."
T_LOGIN_PROMPT="Silakan login ke GitHub:"
else
T_DEPENDENCIES_OK="All dependencies satisfied."
T_DEPENDENCIES_MISSING="Missing dependencies:"
T_RUN_SETUP="Run: gitflux setup"
T_NOT_GIT_REPO="Not a Git repository. Run 'git init' or clone first."
T_HELP_LINE="Type 'gitflux help' for command list."
T_FAIL_UNKNOWN="Unknown command:"
T_CONFIRM="Are you sure?"
T_CANCEL="Cancelled."
T_DONE="Done."
T_INVALID_INPUT="Invalid input."
T_YES_NO="[y/N]"
T_DETACHED_HEAD="Detached HEAD or empty repo. Cannot continue."
T_COMMIT_CANCELLED="Commit cancelled."
T_REMOTE_NOT_SET="not set"
T_DEPLOY_START="Deploy to branch"
T_FILE_STAGED="Files staged."
T_FILE_STAGE_FAILED="Failed to stage files."
T_NO_CHANGES="No changes, commit skipped."
T_COMMIT_OK="Commit:"
T_COMMIT_FAILED="Commit failed."
T_PULL_INFO="Pulling latest changes..."
T_PULL_OK="Pull successful."
T_PULL_SKIP="Pull skipped."
T_PUSH_INFO="Pushing to remote..."
T_PUSH_OK="Push successful."
T_PUSH_FAILED="Push failed."
T_DEPLOY_DONE="Deploy finished."
T_SYNC_OK="Sync finished."
T_PUSH_SUCCESS="Push to '%s' successful."
T_PUSH_ERROR="Push failed."
T_PULL_SUCCESS="Pull from '%s' successful."
T_PULL_ERROR="Pull failed."
T_STASH_SAVED="Changes saved."
T_STASH_POPPED="Stash popped."
T_STASH_APPLIED="Stash applied."
T_STASH_DROPPED="Stash dropped."
T_USAGE_STASH="Usage: list, save [msg], pop, apply, drop"
T_TAG_CREATED="Tag '%s' created."
T_TAG_DELETED="Tag '%s' deleted."
T_TAG_PUSHED="Tags pushed."
T_USAGE_TAG="Usage: list, create <name> [-m msg], push, delete <name>"
T_TAG_NAME_REQUIRED="Tag name required."
T_TAG_INVALID_NAME="Tag name contains invalid characters."
T_REMOTE_ADDED="Remote '%s' added."
T_REMOTE_UPDATED="Remote '%s' updated."
T_REMOTE_DELETED="Remote '%s' deleted."
T_REMOTE_RENAMED="Remote '%s' renamed to '%s'."
T_USAGE_REMOTE="Usage: show, add <name> <url>, set <name> <url>, rename <old> <new>, delete <name>"
T_REMOTE_NAME_REQUIRED="Remote name required."
T_REPO_INIT="Repo '%s' initialized. Add remote: gitflux remote add origin <url>"
T_FOLDER_EXISTS="Folder '%s' already exists."
T_CREATE_FOLDER_FAIL="Failed to create folder."
T_BRANCH_CREATED="Branch '%s' created."
T_BRANCH_SWITCHED="Switched to '%s'."
T_BRANCH_DELETED="Branch '%s' deleted."
T_BRANCH_DELETE_FAIL="Failed to delete branch."
T_BRANCH_RENAMED="Branch '%s' renamed to '%s'."
T_USAGE_BRANCH="Usage: list, create <name>, switch <name>, delete <name>, rename <old> <new>"
T_MERGE_OK="Merge successful."
T_MERGE_CONFLICT="Merge conflict. Resolve manually."
T_USAGE_MERGE="Usage: gitflux merge <branch> [--no-ff|--squash]"
T_FETCH_OK="Fetch complete."
T_RESET_SOFT="Soft reset to '%s'."
T_RESET_HARD="Hard reset to '%s'."
T_USAGE_RESET="Usage: gitflux reset [soft|hard] [target]"
T_RESET_HARD_CONFIRM="Hard reset will discard changes. Are you sure?"
T_SQUASH_DONE="Squash complete."
T_SQUASH_INVALID_N="Number of commits must be an integer of at least 2."
T_SQUASH_TOO_LARGE="Number of commits exceeds total commits."
T_REBASE_DONE="Rebase complete."
T_REBASE_CONFLICT="Rebase conflict."
T_CHERRY_PICK_DONE="Commit cherry-picked."
T_USAGE_CHERRY_PICK="Usage: gitflux cherry-pick <commit>"
T_BISECT_START="Bisect started."
T_BISECT_GOOD="Commit marked good."
T_BISECT_BAD="Commit marked bad."
T_BISECT_RESET="Bisect reset."
T_USAGE_BISECT="Usage: start, good, bad, reset"
T_REPO_CREATE_OK="GitHub repo '%s' created."
T_REPO_CREATE_FAIL="Failed to create repo."
T_CLONE_OK="Clone complete."
T_CLONE_FAIL="Clone failed."
T_GIST_CREATED="Gist created."
T_GIST_EDITED="Gist edited."
T_GIST_DELETED="Gist deleted."
T_ISSUE_CREATED="Issue created."
T_ISSUE_CLOSED="Issue #%s closed."
T_PR_CREATED="PR created."
T_PR_MERGED="PR #%s merged."
T_PR_CHECKOUT="Checked out PR #%s."
T_PR_REVIEWED="Reviewed PR #%s."
T_RELEASE_CREATED="Release '%s' created."
T_RELEASE_DELETED="Release '%s' deleted."
T_ACTIONS_WATCH="Watching run #%s."
T_ACTIONS_TRIGGER="Workflow '%s' triggered."
T_USAGE_REPO="Usage: gitflux repo <name> [public|private]"
T_USAGE_CLONE="Usage: gitflux clone <user/repo> [--depth N] [--branch name]"
T_USAGE_GIST="Usage: list, create <file>, edit <id>, delete <id>"
T_USAGE_ISSUE="Usage: list, create <title>, close <number>, view <number>"
T_USAGE_PR="Usage: list, create <title>, merge <number>, checkout <number>, review <number>"
T_USAGE_RELEASE="Usage: list, create <tag>, delete <tag>"
T_USAGE_ACTIONS="Usage: list, watch <id>, trigger <workflow>"
T_BACKUP_START="Backing up all repos to '%s'..."
T_BACKUP_DONE="Backup finished."
T_STATS_COMMIT_BY="Commits by %s:"
T_STATS_LINES="Total lines of code:"
T_STATS_LANG="Dominant language:"
T_DAEMON_START="Gitflux daemon running (sync every %s seconds)..."
T_DAEMON_ALREADY="Daemon is already running."
T_DAEMON_STOPPED="Daemon stopped."
T_DAEMON_NOT_RUNNING="Daemon is not running."
T_DAEMON_STATUS="Daemon running with PID %s"
T_USAGE_DAEMON="Usage: start [seconds], stop, status, restart [seconds]"
T_WEBHOOK_OK="Webhook sent."
T_WEBHOOK_FAIL="Webhook failed."
T_WEBHOOK_RETRY="Retrying... (%s/%s)"
T_WEBHOOK_URL_NOT_SET="WEBHOOK_URL not set."
T_KEYGEN_OK="Key created: %s"
T_KEYGEN_FAIL="Failed to create key."
T_KEYGEN_BACKUP="Old key backed up to: %s"
T_CONFIG_SET="%s set to %s."
T_CONFIG_SET_FAIL="Failed to set %s."
T_CONFIG_REMOTE_OK="Remote configured."
T_USAGE_CONFIG="Usage: show, set <key> <value> [--local], remote <url>"
T_UNDO_COMMIT="Last commit undone (files kept)."
T_UNDO_FILE="File '%s' restored."
T_UNDO_HARD="All changes discarded."
T_USAGE_UNDO="Usage: commit, file <name>, hard"
T_UNDO_HARD_CONFIRM="This will discard ALL changes. Are you sure?"
T_SETUP_DONE="Setup complete. Try: gitflux help"
T_ALREADY_LOGIN="Already logged into GitHub."
T_LOGIN_PROMPT="Please login to GitHub:"
fi

# ==================== EXTRA MESSAGES ====================
if [ "$GITFLUX_LANG" = "id" ]; then
T_INVALID_CHARS="Karakter tidak valid terdeteksi di %s."
T_NO_ORIGIN="Remote 'origin' belum disetel. Jalankan: gitflux remote add origin <url>"
T_REBASE_IN_PROGRESS="Rebase/merge sedang berlangsung. Selesaikan dulu (--continue / --abort)."
T_BRANCH_MISMATCH="Branch '%s' bukan branch aktif ('%s'). Pindah dulu: gitflux branch switch %s"
T_SENSITIVE_WARN="File sensitif terdeteksi di staging:%s"
T_NEED_TOOL="Perintah '%s' tidak ditemukan. Jalankan: gitflux setup"
T_NEED_GH_AUTH="Belum login GitHub. Jalankan: gh auth login"
T_BAD_NUMBER="Harus berupa angka positif."
T_BAD_URL="URL tidak valid atau tidak diizinkan."
T_BAD_REF="Nama/ref tidak valid"
T_KEY_NOT_ALLOWED="Kunci konfigurasi '%s' tidak diizinkan."
T_KEY_EXISTS="Kunci '%s' sudah ada. Tidak ditimpa."
T_BACKUP_FAILED="Backup gagal untuk %s repo."
T_DIRTY="Working tree tidak bersih. Commit atau stash dulu."
T_BAD_INTERVAL="Interval harus berupa angka positif (detik)."
T_STATS_TOP="Kontributor teratas:"
T_NEED_TARGET="Reset hard memerlukan target eksplisit (mis. HEAD~1)."
T_FILE_NOT_FOUND="File tidak ditemukan: %s"
T_SENSITIVE_REFUSE="Ditolak: '%s' tampak sebagai file sensitif."
T_MERGE_FAIL="Merge gagal."
T_STATUS_HEADER="Status repositori"
T_STATUS_BRANCH="Branch"
T_STATUS_REMOTE="Remote"
T_STATUS_UPSTREAM="Upstream"
T_STATUS_WORKING="Working tree"
T_WORKING_CLEAN="bersih"
T_SYNC_START="Sinkronisasi di branch '%s'"
T_BACKUP_FOUND="Ditemukan %s repo. Memulai backup paralel (maks 4)..."
T_SETUP_HEADER="Menyiapkan dependensi"
T_LOGIN_HEADER="Autentikasi GitHub"
T_TIP_HEADER="Tips cepat"
else
T_INVALID_CHARS="Invalid characters detected in %s."
T_NO_ORIGIN="Remote 'origin' is not set. Run: gitflux remote add origin <url>"
T_REBASE_IN_PROGRESS="A rebase/merge is in progress. Finish it first (--continue / --abort)."
T_BRANCH_MISMATCH="Branch '%s' is not the current branch ('%s'). Switch first: gitflux branch switch %s"
T_SENSITIVE_WARN="Sensitive files detected in staging:%s"
T_NEED_TOOL="Command '%s' not found. Run: gitflux setup"
T_NEED_GH_AUTH="Not logged into GitHub. Run: gh auth login"
T_BAD_NUMBER="Must be a positive number."
T_BAD_URL="Invalid or disallowed URL."
T_BAD_REF="Invalid name/ref"
T_KEY_NOT_ALLOWED="Config key '%s' is not allowed."
T_KEY_EXISTS="Key '%s' already exists. Not overwriting."
T_BACKUP_FAILED="Backup failed for %s repo(s)."
T_DIRTY="Working tree is not clean. Commit or stash first."
T_BAD_INTERVAL="Interval must be a positive integer (seconds)."
T_STATS_TOP="Top contributors:"
T_NEED_TARGET="Hard reset requires an explicit target (e.g. HEAD~1)."
T_FILE_NOT_FOUND="File not found: %s"
T_SENSITIVE_REFUSE="Refused: '%s' looks like a sensitive file."
T_MERGE_FAIL="Merge failed."
T_STATUS_HEADER="Repository status"
T_STATUS_BRANCH="Branch"
T_STATUS_REMOTE="Remote"
T_STATUS_UPSTREAM="Upstream"
T_STATUS_WORKING="Working tree"
T_WORKING_CLEAN="clean"
T_SYNC_START="Sync on branch '%s'"
T_BACKUP_FOUND="Found %s repo(s). Starting parallel backup (max 4)..."
T_SETUP_HEADER="Setting up dependencies"
T_LOGIN_HEADER="GitHub authentication"
T_TIP_HEADER="Quick tips"
fi

# ==================== ADAPTIVE UI (width, color, wrap) ====================
term_width() {
    local w="" sz=""
    if [ -t 1 ]; then
        w="$(tput cols 2>/dev/null || true)"
    elif [ -e /dev/tty ]; then
        sz="$(stty size </dev/tty 2>/dev/null || true)"
        w="${sz##* }"
    fi
    case "$w" in ''|*[!0-9]*) w=0 ;; esac
    if [ "$w" -lt 40 ]; then
        case "${COLUMNS:-}" in ''|*[!0-9]*) w=80 ;; *) w="$COLUMNS" ;; esac
    fi
    case "$w" in ''|*[!0-9]*) w=80 ;; esac
    [ "$w" -ge 40 ] || w=40
    [ "$w" -le 200 ] || w=200
    echo "$w"
}

if { [ -t 1 ] || [ -n "${FORCE_COLOR:-}" ]; } && [ -z "${NO_COLOR:-}" ]; then
    C_RESET=$'\033[0m'
    C_BOLD=$'\033[1m'
    C_DIM=$'\033[2m'
    C_ITALIC=$'\033[3m'
    C_UL=$'\033[4m'
    C_RED=$'\033[1;31m'
    C_GREEN=$'\033[1;32m'
    C_YELLOW=$'\033[1;33m'
    C_BLUE=$'\033[1;34m'
    C_MAGENTA=$'\033[1;35m'
    C_CYAN=$'\033[1;36m'
    C_GRAY=$'\033[90m'
    C_SEC=$'\033[1;36m'
    C_CMD=$'\033[1m'
    C_DESC=$'\033[2m'
    C_OFF=$'\033[0m'
else
    C_RESET=''; C_BOLD=''; C_DIM=''; C_ITALIC=''; C_UL=''
    C_RED=''; C_GREEN=''; C_YELLOW=''; C_BLUE=''; C_MAGENTA=''; C_CYAN=''; C_GRAY=''
    C_SEC=''; C_CMD=''; C_DESC=''; C_OFF=''
fi

if [ "${GITFLUX_ASCII:-0}" = "1" ]; then
    ICON_INFO='[i]'; ICON_OK='[+]'; ICON_FAIL='[x]'; ICON_WARN='[!]'
    ICON_STEP='>'; ICON_DOT='*'; ICON_BRANCH='@'
    ARROW_UP='^'; ARROW_DOWN='v'
    BOX_H='-'; BOX_V='|'
    BOX_TL='+'; BOX_TR='+'; BOX_BL='+'; BOX_BR='+'
    BOX_LT='['; BOX_RT=']'
else
    case "${LC_ALL:-}${LC_CTYPE:-}${LANG:-}" in
        *[Uu][Tt][Ff]-*8*|*[Uu][Tt][Ff]8*|'')
            ICON_INFO='ℹ'; ICON_OK='✔'; ICON_FAIL='✖'; ICON_WARN='⚠'
            ICON_STEP='▸'; ICON_DOT='•'; ICON_BRANCH='⎇'
            ARROW_UP='↑'; ARROW_DOWN='↓'
            BOX_H='─'; BOX_V='│'
            BOX_TL='┌'; BOX_TR='┐'; BOX_BL='└'; BOX_BR='┘'
            BOX_LT='「'; BOX_RT='」'
            ;;
        *)
            ICON_INFO='[i]'; ICON_OK='[+]'; ICON_FAIL='[x]'; ICON_WARN='[!]'
            ICON_STEP='>'; ICON_DOT='*'; ICON_BRANCH='@'
            ARROW_UP='^'; ARROW_DOWN='v'
            BOX_H='-'; BOX_V='|'
            BOX_TL='+'; BOX_TR='+'; BOX_BL='+'; BOX_BR='+'
            BOX_LT='['; BOX_RT=']'
            ;;
    esac
fi

HELP_W="$(term_width)"

_t() { if [ "$GITFLUX_LANG" = "id" ]; then printf '%s' "$2"; else printf '%s' "$1"; fi; }

# ==================== BOX-DRAWING HELP RENDERER ====================
_visible_len() {
    local s
    s=$(printf '%s' "$1" | sed $'s/\033\[[0-9;]*[a-zA-Z]//g')
    printf '%d' "${#s}"
}

_repeat() {
    local ch="$1" n="$2" out=""
    local i
    for (( i=0; i<n; i++ )); do out+="$ch"; done
    printf '%s' "$out"
}

_box_width() {
    local w=$HELP_W
    [ "$w" -gt 76 ] && w=76
    [ "$w" -lt 40 ] && w=40
    printf '%d' "$w"
}

_box_line() {
    local content="$1"
    local W; W=$(_box_width)
    local inner=$(( W - 2 ))
    local visible
    visible=$(_visible_len "$content")
    if [ "$visible" -le "$inner" ]; then
        printf '%s%s%*s%s\n' "$BOX_V" "$content" $((inner - visible)) '' "$BOX_V"
    else
        local plain
        plain=$(printf '%s' "$content" | sed $'s/\033\[[0-9;]*[a-zA-Z]//g')
        local remaining="$plain"
        while [ -n "$remaining" ]; do
            local chunk="${remaining:0:$inner}"
            remaining="${remaining:$inner}"
            printf '%s%s%*s%s\n' "$BOX_V" "$chunk" $((inner - ${#chunk})) '' "$BOX_V"
        done
    fi
}

_box_top() {
    local W; W=$(_box_width)
    printf '%s%s%s\n' "$BOX_TL" "$(_repeat "$BOX_H" $((W-2)))" "$BOX_TR"
}

_box_bottom() {
    local W; W=$(_box_width)
    printf '%s%s%s\n' "$BOX_BL" "$(_repeat "$BOX_H" $((W-2)))" "$BOX_BR"
}

_box_section_top() {
    local title="$1"
    local W; W=$(_box_width)
    local left=5
    local right=$(( W - 8 - ${#title} - left ))
    [ "$right" -lt 1 ] && right=1
    printf '%s%s %s%s%s%s %s%s\n' \
        "$BOX_TL" \
        "$(_repeat "$BOX_H" "$left")" \
        "$BOX_LT" "$C_SEC$title$C_OFF" "$BOX_RT" \
        "$(_repeat "$BOX_H" "$right")" \
        "$BOX_TR"
}

_box_item() {
    local cmd="$1" desc="$2"
    _box_line "  ${C_CMD}${cmd}${C_OFF}"
    if [ -n "$desc" ]; then
        _box_line "    ${C_DESC}${desc}${C_OFF}"
    fi
}

_help_header() {
    local branch
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        branch=$(git symbolic-ref --short -q HEAD 2>/dev/null || echo "detached")
    else
        branch=$(_t '(not a git repo)' '(bukan repo git)')
    fi
    local dt
    dt=$(date '+%Y-%m-%d %H:%M')

    _box_top
    _box_line ""
    _box_line "  ${C_BOLD}Gitflux${C_OFF} ${C_DIM}v${VERSION}${C_OFF}"
    _box_line "  ${C_DIM}$(_t 'GitHub CLI Assistant' 'Asisten CLI GitHub')${C_OFF}"
    _box_line ""
    _box_line "  ${C_DIM}$(_t 'Developer' 'Developer')${C_OFF}  : AhriDeValiente"
    _box_line "  ${C_DIM}$(_t 'Branch' 'Branch')${C_OFF}     : ${C_CYAN}${branch}${C_OFF}"
    _box_line "  ${C_DIM}$(_t 'Date' 'Tanggal')${C_OFF}       : ${dt}"
    _box_line ""
    _box_bottom
    printf '\n'
}

_help_signature() {
    printf '%s© Gitflux v%s | AhriDeValiente%s\n' "$C_DIM" "$VERSION" "$C_OFF"
}

# ==================== UI FUNCTIONS ====================
info()  { printf '%s%s%s %s\n' "$C_CYAN" "$ICON_INFO" "$C_OFF" "$*"; }
ok()    { printf '%s%s%s %s\n' "$C_GREEN" "$ICON_OK" "$C_OFF" "$*"; }
fail()  { printf '%s%s%s %s\n' "$C_RED" "$ICON_FAIL" "$C_OFF" "$*" >&2; }
warn()  { printf '%s%s%s %s\n' "$C_YELLOW" "$ICON_WARN" "$C_OFF" "$*"; }
step()  { printf '%s%s%s %s%s%s\n' "$C_GRAY" "$ICON_STEP" "$C_OFF" "$C_BOLD" "$*" "$C_RESET"; }
dim()   { printf '%s%s%s\n' "$C_DIM" "$*" "$C_RESET"; }

banner() {
    printf '\n'
    printf '  %s⚡ Gitflux%s %sv%s%s %s— %s%s\n' \
        "$C_CYAN" "$C_RESET" "$C_GRAY" "$VERSION" "$C_RESET" \
        "$C_DIM" "$(_t 'Cross-Platform CLI (Stable)' 'CLI Lintas Platform (Stable)')" "$C_RESET"
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        local b
        b="$(git symbolic-ref --short -q HEAD 2>/dev/null || echo 'detached')"
        printf '  %sby AhriDeValiente • %s %s%s%s\n' \
            "$C_DIM" "$ICON_BRANCH" "$C_BOLD" "$b" "$C_RESET"
    else
        printf '  %sby AhriDeValiente%s\n' "$C_DIM" "$C_RESET"
    fi
    printf '\n'
}

# ==================== SAFETY WRAPPERS ====================
run_git() {
    local rc=0
    git "$@" || rc=$?
    [ "$rc" -eq 0 ] || fail "Git command failed (exit $rc): git $*"
    return "$rc"
}

run_gh() {
    local rc=0
    gh "$@" || rc=$?
    [ "$rc" -eq 0 ] || fail "GitHub CLI failed (exit $rc): gh $*"
    return "$rc"
}

mask_url() { sed -E 's#(://)[^/@[:space:]]+@#\1***@#g'; }

# ==================== INPUT VALIDATION ====================
RE_REPO='^[A-Za-z0-9][A-Za-z0-9._-]*(/[A-Za-z0-9][A-Za-z0-9._-]*)?$'
RE_REPO_FULL='^[A-Za-z0-9][A-Za-z0-9._-]*/[A-Za-z0-9][A-Za-z0-9._-]*$'
RE_NAME='^[A-Za-z0-9][A-Za-z0-9._-]*$'

validate_text() {
    local val="$1" ctx="${2:-text}" multiline="${3:-no}"
    if [ "$multiline" = "yes" ]; then val="${val//$'\n'/}"; fi
    if [[ "$val" == *[[:cntrl:]]* ]]; then
        fail "$(printf "$T_INVALID_CHARS" "$ctx")"
        return 1
    fi
}

validate_number() {
    [[ "${1:-}" =~ ^[0-9]+$ ]] || { fail "$T_BAD_NUMBER"; return 1; }
}

validate_id() {
    [[ "${1:-}" =~ ^[A-Za-z0-9]+$ ]] || { fail "$T_INVALID_INPUT"; return 1; }
}

validate_branch_name() {
    local v="${1:-}"
    if [ -z "$v" ] || [[ "$v" == -* ]] || ! git check-ref-format --branch "$v" >/dev/null 2>&1; then
        fail "$T_BAD_REF: $v"
        return 1
    fi
}

validate_tag_name() {
    local t="${1:-}"
    if [ -z "$t" ] || [[ "$t" == -* ]] || ! git check-ref-format "refs/tags/$t" >/dev/null 2>&1; then
        fail "$T_TAG_INVALID_NAME"
        return 1
    fi
}

validate_rev() {
    local v="${1:-}"
    if [ -z "$v" ] || [[ "$v" == -* ]] || [[ "$v" == *[[:cntrl:][:space:]]* ]] \
    || ! git rev-parse --verify --quiet "${v}^{commit}" >/dev/null 2>&1; then
        fail "$T_BAD_REF: $v"
        return 1
    fi
}

validate_remote_name() {
    [[ "${1:-}" =~ $RE_NAME ]] || { fail "$T_INVALID_INPUT"; return 1; }
}

validate_url() {
    local u="${1:-}"
    case "$u" in
        https://*|ssh://*|git@*:*) ;;
        *) fail "$T_BAD_URL"; return 1 ;;
    esac
    case "$u" in
        *[[:space:]]*|*[[:cntrl:]]*|*'"'*|*"'"*|*'\'*|*'`'*|*'$'*|*';'*|*'|'*|*'&'*|*'<'*|*'>'*)
            fail "$T_BAD_URL"; return 1 ;;
    esac
}

is_sensitive() {
    case "${1##*/}" in
        .env|.env.*|*.pem|*.key|*.p12|*.pfx|*.kdbx|.netrc|.npmrc|id_rsa|id_rsa.*|id_ed25519|id_ed25519.*|id_ecdsa|id_ecdsa.*|credentials*|*secret*)
            return 0 ;;
    esac
    return 1
}

warn_sensitive_staged() {
    local f hits=""
    while IFS= read -r -d '' f; do
        if is_sensitive "$f"; then hits="$hits $f"; fi
    done < <(git diff --cached --name-only -z --diff-filter=AM)
    if [ -n "$hits" ]; then
        warn "$(printf "$T_SENSITIVE_WARN" "$hits")"
        return 1
    fi
    return 0
}

confirm() {
    local prompt="${1:-$T_CONFIRM}" ans
    read -rp "$prompt $T_YES_NO " ans || return 1
    [[ "$ans" =~ ^([Yy]|[Yy][Ee][Ss]|[Yy][Aa])$ ]]
}

# ==================== ENVIRONMENT DETECTION ====================
is_termux() { [ -n "${TERMUX_VERSION:-}" ] || [[ "${PREFIX:-}" == *com.termux* ]]; }

detect_os() {
    local os="unknown"
    case "$(uname -s)" in
        Linux)  if is_termux; then os="termux"; else os="linux"; fi ;;
        Darwin) os="macos" ;;
        MINGW*|MSYS*|CYGWIN*) os="windows" ;;
    esac
    echo "$os"
}

OS="$(detect_os)"

check_git() {
    if ! git rev-parse --is-inside-work-tree &>/dev/null; then
        fail "$T_NOT_GIT_REPO"
        return 1
    fi
}

get_branch() {
    local branch
    branch="$(git symbolic-ref --short -q HEAD 2>/dev/null || true)"
    if [ -z "$branch" ]; then
        fail "$T_DETACHED_HEAD"
        return 1
    fi
    echo "$branch"
}

resolve_branch() {
    local cur req="${1:-}"
    cur="$(get_branch)" || return 1
    if [ -n "$req" ]; then
        validate_branch_name "$req" || return 1
        if [ "$req" != "$cur" ]; then
            fail "$(printf "$T_BRANCH_MISMATCH" "$req" "$cur" "$req")"
            return 1
        fi
    fi
    echo "$cur"
}

check_origin() {
    git remote get-url origin >/dev/null 2>&1 || { fail "$T_NO_ORIGIN"; return 1; }
}

rebase_in_progress() {
    [ -d "$(git rev-parse --git-path rebase-merge)" ] \
    || [ -d "$(git rev-parse --git-path rebase-apply)" ] \
    || [ -f "$(git rev-parse --git-path MERGE_HEAD)" ]
}

need() {
    command -v "$1" >/dev/null 2>&1 || { fail "$(printf "$T_NEED_TOOL" "$1")"; return 1; }
}

need_gh() {
    need gh || return 1
    gh auth status >/dev/null 2>&1 || { fail "$T_NEED_GH_AUTH"; return 1; }
}

# ==================== DEPENDENCY INSTALLER ====================
check_deps() {
    local deps=("git" "gh" "curl" "ssh-keygen")
    local missing=() dep
    for dep in "${deps[@]}"; do
        command -v "$dep" &>/dev/null || missing+=("$dep")
    done
    if [ ${#missing[@]} -eq 0 ]; then
        ok "$T_DEPENDENCIES_OK"
    else
        fail "$T_DEPENDENCIES_MISSING ${missing[*]}"
        info "$T_RUN_SETUP"
        return 1
    fi
}

install_deps() {
    local SUDO=""
    step "$T_SETUP_HEADER"
    info "Detecting package manager & installing dependencies..."
    if [ "$OS" = "windows" ]; then
        if command -v winget >/dev/null 2>&1; then
            winget install --id Git.Git -e --source winget
            winget install --id GitHub.cli -e --source winget
            winget install --id OpenSSH.OpenSSH -e --source winget
        elif command -v scoop >/dev/null 2>&1; then
            scoop install git gh openssh
        elif command -v choco >/dev/null 2>&1; then
            choco install git github-cli openssh -y
        else
            fail "Windows: install Git for Windows, GitHub CLI and OpenSSH via winget/scoop/choco."
            return 1
        fi
    elif ! is_termux && [ "$(id -u)" -ne 0 ]; then
        if command -v sudo >/dev/null 2>&1; then SUDO="sudo"
        else fail "Root or sudo is required."; return 1
        fi
    fi
    if is_termux; then
        pkg update -y && pkg install -y git gh curl openssh
    elif command -v apt-get >/dev/null 2>&1; then
        $SUDO apt-get update -qq
        $SUDO apt-get install -y git curl openssh-client
        $SUDO apt-get install -y gh || info "gh not in your apt repos: https://github.com/cli/cli/blob/trunk/docs/install_linux.md"
    elif command -v pacman >/dev/null 2>&1; then
        $SUDO pacman -S --needed --noconfirm git github-cli curl openssh
    elif command -v brew >/dev/null 2>&1; then
        brew install git gh curl openssh
    elif command -v dnf >/dev/null 2>&1; then
        $SUDO dnf install -y git gh curl openssh-clients
    else
        fail "Unsupported package manager. Install manually: git gh curl openssh"
        return 1
    fi
    ok "Dependencies installed."
    check_deps || return 1
    step "$T_LOGIN_HEADER"
    if ! gh auth status &>/dev/null; then
        info "$T_LOGIN_PROMPT"
        gh auth login
    else
        ok "$T_ALREADY_LOGIN"
    fi
    ok "$T_SETUP_DONE"
}

# ==================== CORE COMMANDS ====================
stage_and_commit() {
    local msg="$1" interactive="${2:-yes}"
    run_git add -A || { fail "$T_FILE_STAGE_FAILED"; return 1; }
    ok "$T_FILE_STAGED"
    if git diff --cached --quiet; then
        info "$T_NO_CHANGES"
        return 0
    fi
    if ! warn_sensitive_staged; then
        if [ "$interactive" != "yes" ] || ! confirm; then
            git reset -q 2>/dev/null || true
            fail "$T_CANCEL"
            return 1
        fi
    fi
    run_git commit -m "$msg" || { fail "$T_COMMIT_FAILED"; return 1; }
    ok "$T_COMMIT_OK $msg"
}

pull_rebase() {
    local branch="$1" rc=0
    info "$T_PULL_INFO"
    git ls-remote --exit-code --heads origin "$branch" >/dev/null 2>&1 || rc=$?
    if [ "$rc" -eq 2 ]; then info "$T_PULL_SKIP"; return 0; fi
    if [ "$rc" -ne 0 ]; then fail "$T_PULL_ERROR"; return 1; fi
    if git pull --rebase origin "$branch"; then
        ok "$T_PULL_OK"
    else
        fail "$T_PULL_ERROR"
        return 1
    fi
}

cmd_deploy() {
    check_git || return 1
    local message="${1:-deploy: $(date '+%F %T')}"
    local branch; branch="$(resolve_branch "${2:-}")" || return 1
    validate_text "$message" "commit message" yes || return 1
    check_origin || return 1
    if rebase_in_progress; then fail "$T_REBASE_IN_PROGRESS"; return 1; fi
    step "$T_DEPLOY_START '$branch'..."
    stage_and_commit "$message" || return 1
    pull_rebase "$branch" || return 1
    info "$T_PUSH_INFO"
    run_git push -u origin "$branch" || { fail "$T_PUSH_FAILED"; return 1; }
    ok "$T_PUSH_OK"
    ok "$T_DEPLOY_DONE"
}

cmd_push() {
    check_git || return 1
    local branch; branch="$(resolve_branch "${1:-}")" || return 1
    check_origin || return 1
    if run_git push -u origin "$branch"; then
        ok "$(printf "$T_PUSH_SUCCESS" "$branch")"
    else
        fail "$T_PUSH_ERROR"; return 1
    fi
}

cmd_pull() {
    check_git || return 1
    local branch; branch="$(resolve_branch "${1:-}")" || return 1
    check_origin || return 1
    if run_git pull origin "$branch"; then
        ok "$(printf "$T_PULL_SUCCESS" "$branch")"
    else
        fail "$T_PULL_ERROR"; return 1
    fi
}

cmd_sync() {
    check_git || return 1
    local branch; branch="$(resolve_branch "${1:-}")" || return 1
    check_origin || return 1
    if rebase_in_progress; then fail "$T_REBASE_IN_PROGRESS"; return 1; fi
    step "$(printf "$T_SYNC_START" "$branch")"
    stage_and_commit "sync: $(date '+%F %T')" "${GITFLUX_INTERACTIVE:-yes}" || return 1
    pull_rebase "$branch" || return 1
    run_git push -u origin "$branch" || { fail "$T_PUSH_FAILED"; return 1; }
    ok "$T_PUSH_OK"
    ok "$T_SYNC_OK"
}

cmd_status() {
    check_git || return 1
    local branch url upstream="" ahead=0 behind=0
    local staged=0 dirty=0 untracked=0
    branch="$(git symbolic-ref --short -q HEAD 2>/dev/null || echo '(detached)')"
    url="$(git remote get-url origin 2>/dev/null | mask_url)" || url=""
    [ -n "$url" ] || url="$T_REMOTE_NOT_SET"

    if git rev-parse --abbrev-ref --symbolic-full-name '@{u}' >/dev/null 2>&1; then
        upstream="$(git rev-parse --abbrev-ref --symbolic-full-name '@{u}')"
        local counts
        counts="$(git rev-list --left-right --count 'HEAD...@{u}' 2>/dev/null || echo '0 0')"
        ahead="$(printf '%s' "$counts" | awk '{print $1+0}')"
        behind="$(printf '%s' "$counts" | awk '{print $2+0}')"
    fi

    staged=$(git diff --cached --numstat 2>/dev/null | wc -l | tr -d ' ')
    dirty=$(git diff --name-only 2>/dev/null | wc -l | tr -d ' ')
    untracked=$(git ls-files --others --exclude-standard 2>/dev/null | wc -l | tr -d ' ')

    printf '\n'
    step "$T_STATUS_HEADER"
    printf '\n'
    printf '  %s%s%s   %s%s%s\n' "$C_DIM" "$T_STATUS_BRANCH" "$C_RESET" "$C_BOLD" "$branch" "$C_RESET"
    printf '  %s%s%s   %s\n'         "$C_DIM" "$T_STATUS_REMOTE" "$C_RESET" "$url"
    if [ -n "$upstream" ]; then
        local sync=""
        [ "$ahead" -gt 0 ]  && sync="$sync${C_GREEN}${ARROW_UP}${ahead}${C_RESET} "
        [ "$behind" -gt 0 ] && sync="$sync${C_YELLOW}${ARROW_DOWN}${behind}${C_RESET}"
        [ -z "$sync" ] && sync="${C_DIM}${ICON_OK} up to date${C_RESET}"
        printf '  %s%s%s %s%s%s %s\n' \
            "$C_DIM" "$T_STATUS_UPSTREAM" "$C_RESET" \
            "$C_GRAY" "$upstream" "$C_RESET" "$sync"
    fi

    if [ "$staged" -eq 0 ] && [ "$dirty" -eq 0 ] && [ "$untracked" -eq 0 ]; then
        printf '  %s%s%s %s%s%s%s\n' \
            "$C_DIM" "$T_STATUS_WORKING" "$C_RESET" \
            "$C_GREEN" "$ICON_OK" "$C_RESET" \
            " $T_WORKING_CLEAN"
    else
        local summary=""
        [ "$staged" -gt 0 ]    && summary="$summary ${staged} ${C_DIM}staged${C_RESET}"
        [ "$dirty" -gt 0 ]     && summary="$summary ${dirty} ${C_DIM}modified${C_RESET}"
        [ "$untracked" -gt 0 ] && summary="$summary ${untracked} ${C_DIM}untracked${C_RESET}"
        printf '  %s%s%s %s%s%s%s\n' \
            "$C_DIM" "$T_STATUS_WORKING" "$C_RESET" \
            "$C_YELLOW" "$ICON_WARN" "$C_RESET" \
            "$summary"
        printf '\n'
        git -c color.status=always status --short 2>/dev/null || git status --short
    fi
    printf '\n'
}

cmd_log() {
    check_git || return 1
    local count="${1:-20}"
    validate_number "$count" || return 1
    git log --oneline --graph --decorate --all -"$count"
}

cmd_diff() {
    check_git || return 1
    local rev="${1:-HEAD}"
    local cached=""
    if [ "$rev" = "--cached" ] || [ "$rev" = "--staged" ]; then
        cached="--cached"
        rev="HEAD"
    fi
    validate_rev "$rev" || return 1
    git diff $cached "$rev" --
}

cmd_stash() {
    check_git || return 1
    case "${1:-list}" in
        list) git stash list ;;
        save) local msg="${2:-stash: $(date '+%F %T')}"
              validate_text "$msg" "stash message" || return 1
              run_git stash push --include-untracked -m "$msg" && ok "$T_STASH_SAVED" ;;
        pop)  run_git stash pop && ok "$T_STASH_POPPED" ;;
        apply) local n="${2:-0}"
               validate_number "$n" || return 1
               run_git stash apply "stash@{$n}" && ok "$T_STASH_APPLIED" ;;
        drop) local n="${2:-0}"
              validate_number "$n" || return 1
              confirm || { fail "$T_CANCEL"; return 1; }
              run_git stash drop "stash@{$n}" && ok "$T_STASH_DROPPED" ;;
        *)    fail "$T_USAGE_STASH"; return 1 ;;
    esac
}

cmd_tag() {
    check_git || return 1
    local t="${2:-}"
    case "${1:-list}" in
        list)   git tag -l ;;
        create) [ -n "$t" ] || { fail "$T_TAG_NAME_REQUIRED"; return 1; }
                validate_tag_name "$t" || return 1
                if [ "${3:-}" = "-m" ] && [ -n "${4:-}" ]; then
                    run_git tag -a "$t" -m "$4" && ok "$(printf "$T_TAG_CREATED" "$t")"
                else
                    run_git tag "$t" && ok "$(printf "$T_TAG_CREATED" "$t")"
                fi ;;
        push)   check_origin || return 1
                run_git push origin --tags && ok "$T_TAG_PUSHED" ;;
        delete) [ -n "$t" ] || { fail "$T_TAG_NAME_REQUIRED"; return 1; }
                validate_tag_name "$t" || return 1
                confirm || { fail "$T_CANCEL"; return 1; }
                local rc=0
                if git rev-parse -q --verify "refs/tags/$t" >/dev/null; then
                    run_git tag -d "$t" || rc=1
                fi
                if git remote get-url origin >/dev/null 2>&1 \
                && git ls-remote --exit-code --tags origin "refs/tags/$t" >/dev/null 2>&1; then
                    run_git push origin --delete "refs/tags/$t" || rc=1
                fi
                if [ "$rc" -eq 0 ]; then ok "$(printf "$T_TAG_DELETED" "$t")"; else return 1; fi ;;
        *)      fail "$T_USAGE_TAG"; return 1 ;;
    esac
}

cmd_remote() {
    check_git || return 1
    local name="${2:-}" url="${3:-}"
    case "${1:-show}" in
        show)   git remote -v | mask_url ;;
        add)    { [ -n "$name" ] && [ -n "$url" ]; } || { fail "$T_USAGE_REMOTE"; return 1; }
                validate_remote_name "$name" || return 1
                validate_url "$url" || return 1
                run_git remote add "$name" "$url" && ok "$(printf "$T_REMOTE_ADDED" "$name")" ;;
        set)    { [ -n "$name" ] && [ -n "$url" ]; } || { fail "$T_USAGE_REMOTE"; return 1; }
                validate_remote_name "$name" || return 1
                validate_url "$url" || return 1
                run_git remote set-url "$name" "$url" && ok "$(printf "$T_REMOTE_UPDATED" "$name")" ;;
        rename) local new_name="${3:-}"
                { [ -n "$name" ] && [ -n "$new_name" ]; } || { fail "$T_USAGE_REMOTE"; return 1; }
                validate_remote_name "$name" || return 1
                validate_remote_name "$new_name" || return 1
                run_git remote rename "$name" "$new_name" && ok "$(printf "$T_REMOTE_RENAMED" "$name" "$new_name")" ;;
        delete) [ -n "$name" ] || { fail "$T_REMOTE_NAME_REQUIRED"; return 1; }
                validate_remote_name "$name" || return 1
                run_git remote remove "$name" && ok "$(printf "$T_REMOTE_DELETED" "$name")" ;;
        *)      fail "$T_USAGE_REMOTE"; return 1 ;;
    esac
}

cmd_init() {
    local name="${1:-my-project}"
    [[ "$name" =~ $RE_NAME ]] || { fail "$T_INVALID_INPUT"; return 1; }
    if [ -e "$name" ]; then fail "$(printf "$T_FOLDER_EXISTS" "$name")"; return 1; fi
    mkdir -p -- "$name" || { fail "$T_CREATE_FOLDER_FAIL"; return 1; }
    git -C "$name" init -q || return 1
    printf '# %s\n' "$name" > "$name/README.md"
    printf 'node_modules/\n.env\n.env.*\n*.pem\n*.key\n' > "$name/.gitignore"
    run_git -C "$name" add -A || return 1
    run_git -C "$name" commit -q -m "init: first commit" \
    || { fail "$T_COMMIT_FAILED ($(_t 'check' 'cek'): gitflux config set user.name / user.email)"; return 1; }
    ok "$(printf "$T_REPO_INIT" "$name")"
}

cmd_branch() {
    check_git || return 1
    local a="${2:-}" b="${3:-}"
    case "${1:-list}" in
        list)   git branch -a ;;
        create) [ -n "$a" ] || { fail "$T_USAGE_BRANCH"; return 1; }
                validate_branch_name "$a" || return 1
                run_git switch -c "$a" && ok "$(printf "$T_BRANCH_CREATED" "$a")" ;;
        switch) [ -n "$a" ] || { fail "$T_USAGE_BRANCH"; return 1; }
                validate_branch_name "$a" || return 1
                run_git switch "$a" && ok "$(printf "$T_BRANCH_SWITCHED" "$a")" ;;
        delete) [ -n "$a" ] || { fail "$T_USAGE_BRANCH"; return 1; }
                validate_branch_name "$a" || return 1
                if run_git branch -d "$a"; then ok "$(printf "$T_BRANCH_DELETED" "$a")"
                else fail "$T_BRANCH_DELETE_FAIL"; return 1; fi ;;
        rename) { [ -n "$a" ] && [ -n "$b" ]; } || { fail "$T_USAGE_BRANCH"; return 1; }
                validate_branch_name "$a" || return 1
                validate_branch_name "$b" || return 1
                run_git branch -m "$a" "$b" && ok "$(printf "$T_BRANCH_RENAMED" "$a" "$b")" ;;
        *)      fail "$T_USAGE_BRANCH"; return 1 ;;
    esac
}

cmd_merge() {
    check_git || return 1
    local b="${1:-}"
    local strategy=""
    [ -n "$b" ] || { fail "$T_USAGE_MERGE"; return 1; }
    if [ "${2:-}" = "--no-ff" ]; then
        strategy="--no-ff"
    elif [ "${2:-}" = "--squash" ]; then
        strategy="--squash"
    fi
    validate_rev "$b" || return 1
    if run_git merge $strategy "$b"; then
        ok "$T_MERGE_OK"
        return 0
    fi
    if [ -n "$(git ls-files -u)" ]; then fail "$T_MERGE_CONFLICT"; else fail "$T_MERGE_FAIL"; fi
    return 1
}

cmd_fetch() {
    check_git || return 1
    run_git fetch --all --prune && ok "$T_FETCH_OK"
}

cmd_reset() {
    check_git || return 1
    local mode="${1:-soft}" target="${2:-}"
    case "$mode" in
        soft|hard) ;;
        *) fail "$T_USAGE_RESET"; return 1 ;;
    esac
    if [ "$mode" = "hard" ] && [ -z "$target" ]; then fail "$T_NEED_TARGET"; return 1; fi
    target="${target:-HEAD~1}"
    validate_rev "$target" || return 1
    if [ "$mode" = "hard" ]; then
        info "-> $(git log --oneline -1 "$target")"
        confirm "$T_RESET_HARD_CONFIRM" || { fail "$T_CANCEL"; return 1; }
    fi
    case "$mode" in
        soft) run_git reset --soft "$target" && ok "$(printf "$T_RESET_SOFT" "$target")" ;;
        hard) run_git reset --hard "$target" && ok "$(printf "$T_RESET_HARD" "$target")" ;;
    esac
}

cmd_reflog() {
    check_git || return 1
    git reflog -20
}

cmd_squash() {
    check_git || return 1
    local n="${1:-2}"
    { [[ "$n" =~ ^[0-9]+$ ]] && [ "$n" -ge 2 ]; } || { fail "$T_SQUASH_INVALID_N"; return 1; }
    local total; total="$(git rev-list --count HEAD 2>/dev/null || echo 0)"
    if [ "$n" -ge "$total" ]; then fail "$T_SQUASH_TOO_LARGE"; return 1; fi
    if ! git diff --quiet || ! git diff --cached --quiet; then fail "$T_DIRTY"; return 1; fi
    local msg
    msg="$(printf 'squash: %s commits\n' "$n"; git log --format='- %s' -n "$n")"
    run_git reset --soft "HEAD~$n" || return 1
    if ! run_git commit -m "$msg"; then
        git reset --soft ORIG_HEAD >/dev/null 2>&1 || true
        fail "$T_COMMIT_FAILED"
        return 1
    fi
    ok "$T_SQUASH_DONE"
}

cmd_rebase() {
    check_git || return 1
    local target="${1:-}"
    if [ -z "$target" ]; then
        if git rev-parse --verify -q main >/dev/null; then target="main"
        elif git rev-parse --verify -q master >/dev/null; then target="master"
        else target="main"; fi
    fi
    validate_rev "$target" || return 1
    if run_git rebase "$target"; then ok "$T_REBASE_DONE"; return 0; fi
    fail "$T_REBASE_CONFLICT"
    return 1
}

cmd_cherrypick() {
    check_git || return 1
    local c="${1:-}"
    [ -n "$c" ] || { fail "$T_USAGE_CHERRY_PICK"; return 1; }
    validate_rev "$c" || return 1
    run_git cherry-pick "$c" && ok "$T_CHERRY_PICK_DONE"
}

cmd_bisect() {
    check_git || return 1
    case "${1:-start}" in
        start) run_git bisect start && ok "$T_BISECT_START" ;;
        good)  validate_rev "${2:-HEAD}" || return 1
               run_git bisect good "${2:-HEAD}" && ok "$T_BISECT_GOOD" ;;
        bad)   validate_rev "${2:-HEAD}" || return 1
               run_git bisect bad "${2:-HEAD}" && ok "$T_BISECT_BAD" ;;
        reset) run_git bisect reset && ok "$T_BISECT_RESET" ;;
        *)     fail "$T_USAGE_BISECT"; return 1 ;;
    esac
}

# ==================== GITHUB API WRAPPERS ====================
cmd_repo() {
    local name="${1:-}" vis="${2:-private}"
    [ -n "$name" ] || { fail "$T_USAGE_REPO"; return 1; }
    [[ "$name" =~ $RE_REPO ]] || { fail "$T_INVALID_INPUT"; return 1; }
    case "$vis" in public|private|internal) ;; *) fail "$T_USAGE_REPO"; return 1 ;; esac
    if run_gh repo create "$name" "--$vis" --clone; then
        ok "$(printf "$T_REPO_CREATE_OK" "$name")"
    else
        fail "$T_REPO_CREATE_FAIL"; return 1
    fi
}

cmd_clone() {
    local r="${1:-}"
    local depth="" branch=""
    shift || true
    while [ $# -gt 0 ]; do
        case "$1" in
            --depth)  depth="--depth ${2:-}"; shift 2 ;;
            --branch) branch="--branch ${2:-}"; shift 2 ;;
            *) shift ;;
        esac
    done
    [ -n "$r" ] || { fail "$T_USAGE_CLONE"; return 1; }
    [[ "$r" =~ $RE_REPO_FULL ]] || { fail "$T_INVALID_INPUT"; return 1; }
    if run_gh repo clone $depth $branch "$r"; then
        ok "$T_CLONE_OK"
    else
        fail "$T_CLONE_FAIL"; return 1
    fi
}

cmd_gist() {
    local a="${2:-}"
    case "${1:-list}" in
        list)   gh gist list ;;
        create) [ -n "$a" ] || { fail "$T_USAGE_GIST"; return 1; }
                [[ "$a" == -* ]] && a="./$a"
                [ -f "$a" ] || { fail "$(printf "$T_FILE_NOT_FOUND" "$a")"; return 1; }
                if is_sensitive "$a"; then fail "$(printf "$T_SENSITIVE_REFUSE" "$a")"; return 1; fi
                run_gh gist create "$a" -d "Gist from Gitflux" && ok "$T_GIST_CREATED" ;;
        edit)   [ -n "$a" ] || { fail "$T_USAGE_GIST"; return 1; }
                validate_id "$a" || return 1
                run_gh gist edit "$a" && ok "$T_GIST_EDITED" ;;
        delete) [ -n "$a" ] || { fail "$T_USAGE_GIST"; return 1; }
                validate_id "$a" || return 1
                confirm || { fail "$T_CANCEL"; return 1; }
                run_gh gist delete "$a" && ok "$T_GIST_DELETED" ;;
        *)      fail "$T_USAGE_GIST"; return 1 ;;
    esac
}

cmd_issue() {
    local a="${2:-}"
    case "${1:-list}" in
        list)   gh issue list ;;
        create) [ -n "$a" ] || { fail "$T_USAGE_ISSUE"; return 1; }
                validate_text "$a" "issue title" || return 1
                run_gh issue create -t "$a" && ok "$T_ISSUE_CREATED" ;;
        close)  [ -n "$a" ] || { fail "$T_USAGE_ISSUE"; return 1; }
                validate_number "$a" || return 1
                run_gh issue close "$a" && ok "$(printf "$T_ISSUE_CLOSED" "$a")" ;;
        view)   [ -n "$a" ] || { fail "$T_USAGE_ISSUE"; return 1; }
                validate_number "$a" || return 1
                gh issue view "$a" ;;
        *)      fail "$T_USAGE_ISSUE"; return 1 ;;
    esac
}

cmd_pr() {
    local a="${2:-}"
    case "${1:-list}" in
        list)     gh pr list ;;
        create)   [ -n "$a" ] || { fail "$T_USAGE_PR"; return 1; }
                  validate_text "$a" "PR title" || return 1
                  run_gh pr create -t "$a" && ok "$T_PR_CREATED" ;;
        merge)    [ -n "$a" ] || { fail "$T_USAGE_PR"; return 1; }
                  validate_number "$a" || return 1
                  run_gh pr merge "$a" && ok "$(printf "$T_PR_MERGED" "$a")" ;;
        checkout) [ -n "$a" ] || { fail "$T_USAGE_PR"; return 1; }
                  validate_number "$a" || return 1
                  run_gh pr checkout "$a" && ok "$(printf "$T_PR_CHECKOUT" "$a")" ;;
        review)   [ -n "$a" ] || { fail "$T_USAGE_PR"; return 1; }
                  validate_number "$a" || return 1
                  run_gh pr review "$a" && ok "$(printf "$T_PR_REVIEWED" "$a")" ;;
        *)        fail "$T_USAGE_PR"; return 1 ;;
    esac
}

cmd_release() {
    local a="${2:-}"
    case "${1:-list}" in
        list)   gh release list ;;
        create) [ -n "$a" ] || { fail "$T_USAGE_RELEASE"; return 1; }
                validate_tag_name "$a" || return 1
                run_gh release create "$a" && ok "$(printf "$T_RELEASE_CREATED" "$a")" ;;
        delete) [ -n "$a" ] || { fail "$T_USAGE_RELEASE"; return 1; }
                validate_tag_name "$a" || return 1
                run_gh release delete "$a" && ok "$(printf "$T_RELEASE_DELETED" "$a")" ;;
        *)      fail "$T_USAGE_RELEASE"; return 1 ;;
    esac
}

cmd_actions() {
    local a="${2:-}" re='^[A-Za-z0-9][A-Za-z0-9 ._/-]*$'
    case "${1:-list}" in
        list)    gh run list ;;
        watch)   [ -n "$a" ] || { fail "$T_USAGE_ACTIONS"; return 1; }
                 validate_number "$a" || return 1
                 run_gh run watch "$a" && ok "$(printf "$T_ACTIONS_WATCH" "$a")" ;;
        trigger) [ -n "$a" ] || { fail "$T_USAGE_ACTIONS"; return 1; }
                 [[ "$a" =~ $re ]] || { fail "$T_INVALID_INPUT"; return 1; }
                 run_gh workflow run "$a" && ok "$(printf "$T_ACTIONS_TRIGGER" "$a")" ;;
        *)       fail "$T_USAGE_ACTIONS"; return 1 ;;
    esac
}

# ==================== BACKUP ====================
cmd_backup() {
    local dest="${1:-$HOME/gitflux-backups}" max_jobs=4
    local -a pids=()
    local r dir p failed=0 page=1 per_page=100 total=0 started
    mkdir -p -- "$dest"
    step "$(printf "$T_BACKUP_START" "$dest")"
    started=$(date +%s)
    while true; do
        local repos
        repos=$(gh repo list --limit "$per_page" --json nameWithOwner --jq '.[].nameWithOwner' 2>/dev/null || echo "")
        [ -n "$repos" ] || break
        while IFS= read -r r; do
            [ -n "$r" ] || continue
            total=$((total + 1))
            dir="$dest/${r#*/}"
            while [ "$(jobs -rp | wc -l | tr -d ' ')" -ge "$max_jobs" ]; do sleep 1; done
            (
                if [ -d "$dir/.git" ]; then
                    git -C "$dir" fetch --all --prune --quiet && git -C "$dir" pull --ff-only --quiet
                else
                    gh repo clone "$r" "$dir" -- --quiet
                fi
            ) &
            pids+=("$!")
        done <<< "$repos"
        page=$((page + 1))
        [ "$page" -le 10 ] || break
    done
    info "$(printf "$T_BACKUP_FOUND" "$total")"
    for p in ${pids[@]+"${pids[@]}"}; do
        wait "$p" || failed=$((failed + 1))
    done
    if [ "$failed" -gt 0 ]; then
        fail "$(printf "$T_BACKUP_FAILED" "$failed")"
        return 1
    fi
    local elapsed
    elapsed=$(( $(date +%s) - started ))
    ok "$(printf "$T_BACKUP_DONE" ) $((total - failed))/$total ${C_DIM}(${elapsed}s)${C_RESET}"
}

# ==================== STATS ====================
cmd_stats() {
    check_git || return 1
    step "$T_STATS_TOP"
    git shortlog -sn --all | head -10 || true
    echo ""
    step "$T_STATS_LINES"
    if [ -n "$(git ls-files | head -n 1)" ]; then
        git ls-files -z | xargs -0 file 2>/dev/null | grep -v 'binary\|image\|executable' | \
        cut -d: -f1 | xargs cat 2>/dev/null | wc -l | tr -d ' ' || echo 0
    else
        echo 0
    fi
    echo ""
    step "$T_STATS_LANG"
    git ls-files | awk -F/ '{n=$NF} n ~ /\.[^.]+$/ {sub(/.*\./,"",n); c[n]++} END{for(k in c) print c[k], k}' \
    | sort -rn | head -5 || true
}

# ==================== DAEMON ====================
cmd_daemon() {
    check_git || return 1
    local action="${1:-start}"
    local int="${2:-600}"
    local base="${XDG_RUNTIME_DIR:-$HOME/.cache/gitflux}" key pid
    mkdir -p -- "$base" && chmod 700 "$base"
    key="$(git rev-parse --show-toplevel | cksum | cut -d' ' -f1)"
    DAEMON_LOCK="$base/daemon-$key.lock"
    case "$action" in
        start)
            { [[ "$int" =~ ^[0-9]+$ ]] && [ "$int" -ge 1 ]; } || { fail "$T_BAD_INTERVAL"; return 1; }
            if ! mkdir "$DAEMON_LOCK" 2>/dev/null; then
                pid="$(cat "$DAEMON_LOCK/pid" 2>/dev/null || true)"
                if [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null; then
                    fail "$T_DAEMON_ALREADY"
                    return 1
                fi
                rm -rf -- "$DAEMON_LOCK"
                mkdir "$DAEMON_LOCK" 2>/dev/null || { fail "$T_DAEMON_ALREADY"; return 1; }
            fi
            echo $$ > "$DAEMON_LOCK/pid"
            trap 'rm -rf -- "$DAEMON_LOCK"' EXIT
            trap 'exit 130' INT
            trap 'exit 143' TERM
            GITFLUX_INTERACTIVE=no
            step "$(printf "$T_DAEMON_START" "$int")"
            while true; do
                cmd_sync || true
                sleep "$int"
            done
            ;;
        stop)
            if [ -d "$DAEMON_LOCK" ]; then
                pid="$(cat "$DAEMON_LOCK/pid" 2>/dev/null || true)"
                if [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null; then
                    kill "$pid" 2>/dev/null || true
                    rm -rf -- "$DAEMON_LOCK"
                    ok "$T_DAEMON_STOPPED"
                else
                    rm -rf -- "$DAEMON_LOCK"
                    fail "$T_DAEMON_NOT_RUNNING"
                    return 1
                fi
            else
                fail "$T_DAEMON_NOT_RUNNING"
                return 1
            fi
            ;;
        status)
            if [ -d "$DAEMON_LOCK" ]; then
                pid="$(cat "$DAEMON_LOCK/pid" 2>/dev/null || true)"
                if [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null; then
                    ok "$(printf "$T_DAEMON_STATUS" "$pid")"
                else
                    rm -rf -- "$DAEMON_LOCK"
                    fail "$T_DAEMON_NOT_RUNNING"
                    return 1
                fi
            else
                fail "$T_DAEMON_NOT_RUNNING"
                return 1
            fi
            ;;
        restart)
            cmd_daemon stop || true
            sleep 1
            cmd_daemon start "$int"
            ;;
        *)
            fail "$T_USAGE_DAEMON"
            return 1
            ;;
    esac
}

# ==================== WEBHOOK ====================
cmd_webhook() {
    local url="${WEBHOOK_URL:-}" re='^https://[^[:space:]"\\]+$'
    local max_retries=3 retry=0
    [ -n "$url" ] || { fail "$T_WEBHOOK_URL_NOT_SET"; return 1; }
    [[ "$url" =~ $re ]] || { fail "$T_BAD_URL"; return 1; }
    while [ $retry -lt $max_retries ]; do
        local ts; ts="$(date -u '+%Y-%m-%dT%H:%M:%SZ')"
        if printf 'url = "%s"\n' "$url" | curl -fsS --max-time 10 \
        --proto '=https' --proto-redir '=https' -K - \
        -H "Content-Type: application/json" \
        -d "{\"event\":\"ping\",\"tool\":\"gitflux\",\"timestamp\":\"$ts\"}" -o /dev/null; then
            ok "$T_WEBHOOK_OK"
            return 0
        else
            retry=$((retry + 1))
            if [ $retry -lt $max_retries ]; then
                warn "$(printf "$T_WEBHOOK_RETRY" "$retry" "$max_retries")"
                sleep $((retry * 2))
            fi
        fi
    done
    fail "$T_WEBHOOK_FAIL"
    return 1
}

# ==================== KEYGEN ====================
cmd_keygen() {
    local email="${1:-gitflux@termux.local}"
    local force=false
    local dir="$HOME/.ssh" key="$HOME/.ssh/id_ed25519_gitflux"
    if [ "${2:-}" = "--force" ]; then
        force=true
    fi
    validate_text "$email" "email" || return 1
    mkdir -p -- "$dir" && chmod 700 "$dir"
    if [ -e "$key" ] || [ -e "$key.pub" ]; then
        if [ "$force" = true ]; then
            local backup="$key.bak.$(date +%s)"
            mv "$key" "$backup" 2>/dev/null || true
            mv "$key.pub" "$backup.pub" 2>/dev/null || true
            ok "$(printf "$T_KEYGEN_BACKUP" "$backup")"
        else
            fail "$(printf "$T_KEY_EXISTS" "$key")"
            return 1
        fi
    fi
    if (umask 077; ssh-keygen -t ed25519 -C "$email" -f "$key"); then
        ok "$(printf "$T_KEYGEN_OK" "$key")"
        echo ""
        info "Public key:"
        cat -- "$key.pub"
        echo ""
        info "$(_t 'Add it to GitHub:' 'Tambahkan ke GitHub:') gh ssh-key add \"$key.pub\""
    else
        fail "$T_KEYGEN_FAIL"
        return 1
    fi
}

# ==================== CONFIG ====================
cmd_config() {
    case "${1:-show}" in
        show)   git config --list | mask_url ;;
        set)    [ $# -ge 3 ] || { fail "$T_USAGE_CONFIG"; return 1; }
                local scope="--global"
                if [ "${4:-}" = "--local" ]; then
                    scope="--local"
                fi
                case "$2" in
                    user.name|user.email|user.signingkey|init.defaultBranch|pull.rebase|push.autoSetupRemote|core.autocrlf|commit.gpgsign|core.editor|merge.tool|diff.tool) ;;
                    *) fail "$(printf "$T_KEY_NOT_ALLOWED" "$2")"; return 1 ;;
                esac
                validate_text "$3" "config value" || return 1
                if run_git config $scope "$2" "$3"; then ok "$(printf "$T_CONFIG_SET" "$2" "$3")"
                else fail "$(printf "$T_CONFIG_SET_FAIL" "$2")"; return 1; fi ;;
        remote) check_git || return 1
                local url="${2:-}"
                [ -n "$url" ] || { fail "$T_USAGE_CONFIG"; return 1; }
                validate_url "$url" || return 1
                if git remote get-url origin >/dev/null 2>&1; then
                    run_git remote set-url origin "$url" || return 1
                else
                    run_git remote add origin "$url" || return 1
                fi
                ok "$T_CONFIG_REMOTE_OK" ;;
        *)      fail "$T_USAGE_CONFIG"; return 1 ;;
    esac
}

cmd_undo() {
    check_git || return 1
    local a="${2:-}"
    case "${1:-commit}" in
        commit) run_git reset --soft HEAD~1 && ok "$T_UNDO_COMMIT" ;;
        file)   [ -n "$a" ] || { fail "$T_USAGE_UNDO"; return 1; }
                validate_text "$a" "file name" || return 1
                run_git restore -- "$a" && ok "$(printf "$T_UNDO_FILE" "$a")" ;;
        hard)   if confirm "$T_UNDO_HARD_CONFIRM"; then
                    run_git reset --hard HEAD && ok "$T_UNDO_HARD"
                else
                    fail "$T_CANCEL"; return 1
                fi ;;
        *)      fail "$T_USAGE_UNDO"; return 1 ;;
    esac
}

# ==================== SETUP & HELP ====================
cmd_setup() { install_deps; }

_help_render() {
    _help_header

    # ─── BASIC COMMANDS ────────────────────────────────────────
    _box_section_top "$(_t 'BASIC COMMANDS' 'PERINTAH DASAR')"
    _box_line ""
    _box_item 'deploy "msg" [branch]'          "$(_t 'Stage, commit, pull --rebase, push' 'Stage, commit, pull --rebase, push')"
    _box_item 'push [branch]'                   "$(_t 'Push to remote' 'Push ke remote')"
    _box_item 'pull [branch]'                   "$(_t 'Pull from remote' 'Pull dari remote')"
    _box_item 'sync [branch]'                   "$(_t 'Commit, pull --rebase, push' 'Commit, pull --rebase, push')"
    _box_item 'status'                          "$(_t 'Repo status + branch/remote info' 'Status repo + info branch/remote')"
    _box_item 'log [count]'                     "$(_t 'Commit history (default 20)' 'Riwayat commit (default 20)')"
    _box_item 'diff [--cached]'                 "$(_t 'Show changes' 'Lihat perubahan')"
    _box_item 'stash list|save|pop|apply|drop'  "$(_t 'Temporary stash' 'Simpan sementara')"
    _box_item 'tag list|create|push|delete'     "$(_t 'Manage tags (create -m = annotated)' 'Kelola tag (create -m = annotated)')"
    _box_item 'remote show|add|set|rename|delete' "$(_t 'Manage remotes' 'Kelola remote')"
    _box_item 'init [name]'                     "$(_t 'Create new repo' 'Buat repo baru')"
    _box_line ""
    _box_bottom
    printf '\n'

    # ─── BRANCH & MERGE ────────────────────────────────────────
    _box_section_top "$(_t 'BRANCH & MERGE' 'BRANCH & MERGE')"
    _box_line ""
    _box_item 'branch list|create|switch|delete|rename' "$(_t 'Manage branches' 'Kelola branch')"
    _box_item 'merge <branch> [--no-ff|--squash]'       "$(_t 'Merge branch' 'Gabungkan branch')"
    _box_item 'fetch'                                    "$(_t 'Fetch all remotes + prune' 'Fetch semua remote + prune')"
    _box_line ""
    _box_bottom
    printf '\n'

    # ─── REWRITE HISTORY ───────────────────────────────────────
    _box_section_top "$(_t 'REWRITE HISTORY' 'REWRITE HISTORY')"
    _box_line ""
    _box_item 'reset soft|hard [target]'    "$(_t 'Reset to commit' 'Reset ke commit')"
    _box_item 'reflog'                       "$(_t 'HEAD recovery' 'Penyelamat HEAD')"
    _box_item 'squash [count]'               "$(_t 'Squash last N commits' 'Gabung N commit terakhir')"
    _box_item 'rebase [branch]'              "$(_t 'Rebase onto branch' 'Rebase ke branch')"
    _box_item 'cherry-pick <commit>'         "$(_t 'Pick a commit' 'Ambil commit')"
    _box_item 'bisect start|good|bad|reset'  "$(_t 'Find bug commit' 'Cari commit bug')"
    _box_line ""
    _box_bottom
    printf '\n'

    # ─── GITHUB API ────────────────────────────────────────────
    _box_section_top 'GITHUB API'
    _box_line ""
    _box_item 'repo <name> [public|private]'                 "$(_t 'Create GitHub repo' 'Buat repo GitHub')"
    _box_item 'clone <user/repo> [--depth N] [--branch b]'    "$(_t 'Clone repo' 'Clone repo')"
    _box_item 'gist list|create|edit|delete'                  "$(_t 'Manage Gists' 'Kelola Gist')"
    _box_item 'issue list|create|close|view'                  "$(_t 'Manage Issues' 'Kelola Issue')"
    _box_item 'pr list|create|merge|checkout|review'          "$(_t 'Manage Pull Requests' 'Kelola Pull Request')"
    _box_item 'release list|create|delete'                    "$(_t 'Manage Releases' 'Kelola Release')"
    _box_item 'actions list|watch|trigger'                    "$(_t 'GitHub Actions' 'GitHub Actions')"
    _box_line ""
    _box_bottom
    printf '\n'

    # ─── AUTOMATION ────────────────────────────────────────────
    _box_section_top "$(_t 'AUTOMATION' 'AUTOMASI')"
    _box_line ""
    _box_item 'backup [folder]'                        "$(_t 'Backup all repos (parallel)' 'Backup semua repo (paralel)')"
    _box_item 'stats'                                   "$(_t 'Contribution stats' 'Statistik kontribusi')"
    _box_item 'daemon start|stop|status|restart [sec]'  "$(_t 'Auto-sync daemon' 'Daemon auto-sync')"
    _box_item 'webhook'                                 "$(_t 'Test webhook (WEBHOOK_URL)' 'Uji webhook (WEBHOOK_URL)')"
    _box_line ""
    _box_bottom
    printf '\n'

    # ─── SETUP & CONFIG ────────────────────────────────────────
    _box_section_top "$(_t 'SETUP & CONFIG' 'SETUP & CONFIG')"
    _box_line ""
    _box_item 'setup'                   "$(_t 'Install dependencies' 'Install dependensi')"
    _box_item 'config show|set|remote'   "$(_t 'Configure git (set --local = per-repo)' 'Konfigurasi git (set --local = per-repo)')"
    _box_item 'undo commit|file|hard'    "$(_t 'Undo changes' 'Batalkan perubahan')"
    _box_item 'keygen [email] [--force]' "$(_t 'Generate SSH key' 'Buat kunci SSH')"
    _box_item 'help'                     "$(_t 'Show this complete help' 'Tampilkan bantuan lengkap ini')"
    _box_line ""
    _box_bottom
    printf '\n'

    # ─── TIPS ──────────────────────────────────────────────────
    _box_section_top "$T_TIP_HEADER"
    _box_line ""
    _box_item 'export GITFLUX_LANG=id|en'        "$(_t 'Switch language' 'Ganti bahasa')"
    _box_item 'export WEBHOOK_URL=https://...'   "$(_t 'Enable notifications' 'Aktifkan notifikasi')"
    _box_item 'export GITFLUX_NOPAGER=1'         "$(_t 'Disable pager (less)' 'Matikan pager (less)')"
    _box_item 'export NO_COLOR=1'                 "$(_t 'Disable colors' 'Matikan warna')"
    _box_item 'export GITFLUX_ASCII=1'            "$(_t 'Force ASCII icons/boxes' 'Paksa ikon/kotak ASCII')"
    _box_item 'export FORCE_COLOR=1'              "$(_t 'Force color when piped' 'Paksa warna saat dipipe')"
    _box_item 'alias gf=gitflux'                  "$(_t 'Short alias in ~/.bashrc' 'Alias pendek di ~/.bashrc')"
    _box_line ""
    _box_bottom
    printf '\n'

    _help_signature
}

cmd_help() {
    if [ -t 1 ] && [ -z "${GITFLUX_NOPAGER:-}" ] && command -v less >/dev/null 2>&1; then
        _help_render | less -R
    else
        _help_render
    fi
}

# ==================== MAIN DISPATCHER ====================
main() {
    local cmd="${1:-help}"
    if [ -t 1 ]; then banner; fi
    case "$cmd" in
        help|--help|-h|setup) ;;
        *) need git || return 1 ;;
    esac
    case "$cmd" in
        repo|clone|gist|issue|pr|release|actions|backup) need_gh || return 1 ;;
        webhook) need curl || return 1 ;;
        keygen)  need ssh-keygen || return 1 ;;
    esac
    case "$cmd" in
        deploy)       shift; cmd_deploy "$@" ;;
        push)         shift; cmd_push "$@" ;;
        pull)         shift; cmd_pull "$@" ;;
        sync)         shift; cmd_sync "$@" ;;
        status)       shift; cmd_status "$@" ;;
        log)          shift; cmd_log "$@" ;;
        diff)         shift; cmd_diff "$@" ;;
        stash)        shift; cmd_stash "$@" ;;
        tag)          shift; cmd_tag "$@" ;;
        remote)       shift; cmd_remote "$@" ;;
        init)         shift; cmd_init "$@" ;;
        branch)       shift; cmd_branch "$@" ;;
        merge)        shift; cmd_merge "$@" ;;
        fetch)        shift; cmd_fetch "$@" ;;
        reset)        shift; cmd_reset "$@" ;;
        reflog)       shift; cmd_reflog "$@" ;;
        squash)       shift; cmd_squash "$@" ;;
        rebase)       shift; cmd_rebase "$@" ;;
        cherry-pick)  shift; cmd_cherrypick "$@" ;;
        bisect)       shift; cmd_bisect "$@" ;;
        repo)         shift; cmd_repo "$@" ;;
        clone)        shift; cmd_clone "$@" ;;
        gist)         shift; cmd_gist "$@" ;;
        issue)        shift; cmd_issue "$@" ;;
        pr)           shift; cmd_pr "$@" ;;
        release)      shift; cmd_release "$@" ;;
        actions)      shift; cmd_actions "$@" ;;
        backup)       shift; cmd_backup "$@" ;;
        stats)        shift; cmd_stats "$@" ;;
        daemon)       shift; cmd_daemon "$@" ;;
        webhook)      shift; cmd_webhook "$@" ;;
        keygen)       shift; cmd_keygen "$@" ;;
        config)       shift; cmd_config "$@" ;;
        undo)         shift; cmd_undo "$@" ;;
        setup)        shift; cmd_setup "$@" ;;
        help|--help|-h) cmd_help ;;
        *)            fail "$T_FAIL_UNKNOWN $cmd"; info "$T_HELP_LINE"; return 1 ;;
    esac
}

main "$@"