set -g fish_transient_prompt 1

if not set -q -g __fish_repo_helpers_defined
    set -g __fish_repo_helpers_defined

    function _git_branch_name
        set -l ref (git symbolic-ref --quiet HEAD 2>/dev/null)
        and echo (string replace -r '^refs/heads/' '' $ref)
        or echo (git rev-parse --short HEAD 2>/dev/null)
    end

    function _is_git_dirty
        not git diff --no-ext-diff --quiet --cached HEAD 2>/dev/null
        or not git diff --no-ext-diff --quiet --exit-code 2>/dev/null
    end

    function _is_git_repo
        command git rev-parse --is-inside-work-tree >/dev/null 2>&1
    end
end

function fish_prompt
    set -l blue (set_color blue)
    set -l yellow (set_color yellow)
    set -l green (set_color green)
    set -l red (set_color red)
    set -l normal (set_color normal)

    set -l cwd "$blue"(prompt_pwd)"$normal"
    set -l branch ''
    set -l dirty ''

    if _is_git_repo
        set branch (_git_branch_name)
        if _is_git_dirty
            set dirty "$red✗$normal"
        end
    end

    set -l branch_str ''
    if test -n "$branch"
        set branch_str " $yellow$branch$normal$dirty"
    end

    echo "$cwd$branch_str"
    echo -n "$green❯ $normal"
end

