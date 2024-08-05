local function BaleiaColorize()
  -- reformats the diff message with diff-so-fancy
  -- format with Ansi color codes (to get diff-so-fancy to work)
  local baleia = require("baleia").setup({})
  baleia.once(vim.api.nvim_get_current_buf())
end

vim.api.nvim_create_user_command("BaleiaColorize", BaleiaColorize, {})

--
local wk = require("which-key")
wk.add({
  { "<leader>o", group = "Octo" },
  { "<leader>op", group = "pull request" },
  { "<leader>opa", desc = "assignee/reviewer" },
  { "<leader>or", desc = "reactions" },
})

return {
  {
    "pwntester/octo.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>opl", ":Octo pr list<CR>", desc = "List repo PRs" },
      { "<leader>opdd", ":Octo pr diff<CR>", desc = "Diff PR" },
      { "<leader>oprf", ":Octo review submit<CR>", desc = "Finish (submit) review" },
      { "<leader>opdf", ":%!diff-so-fancy<CR>:BaleiaColorize<CR>", desc = "Fancy format the diff" },
    },
    config = function()
      require("octo").setup({
        use_local_fs = false, -- use local files on right side of reviews
        enable_builtin = false, -- shows a list of builtin actions when no action is provided
        default_remote = { "upstream", "origin" }, -- order to try remotes
        ssh_aliases = {}, -- SSH aliases. e.g. `ssh_aliases = {["github.com-work"] = "github.com"}`
        picker_config = {
          mappings = {
            open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
            copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
            checkout_pr = { lhs = "<C-o>", desc = "checkout pull request" },
            merge_pr = { lhs = "<C-r>", desc = "merge pull request" },
          },
        },
        reaction_viewer_hint_icon = "", -- marker for user reactions
        user_icon = " ", -- user icon
        timeline_marker = "", -- timeline marker
        timeline_indent = "2", -- timeline indentation
        right_bubble_delimiter = "", -- bubble delimiter
        left_bubble_delimiter = "", -- bubble delimiter
        github_hostname = "", -- GitHub Enterprise host
        snippet_context_lines = 4, -- number or lines around commented lines
        gh_env = {}, -- extra environment variables to pass on to GitHub CLI, can be a table or function returning a table
        timeout = 5000, -- timeout for requests between the remote server
        ui = {
          use_signcolumn = true, -- show "modified" marks on the sign column
        },
        issues = {
          order_by = { -- criteria to sort results of `Octo issue list`
            field = "UPDATED_AT", -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
            direction = "DESC", -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
          },
        },
        pull_requests = {
          order_by = { -- criteria to sort the results of `Octo pr list`
            field = "UPDATED_AT", -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
            direction = "DESC", -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
          },
          always_select_remote_on_create = false, -- always give prompt to select base remote repo when creating PRs
        },
        file_panel = {
          size = 10, -- changed files panel rows
          use_icons = true, -- use web-devicons in file panel (if false, nvim-web-devicons does not need to be installed)
        },
        mappings = {
          issue = {
            close_issue = { lhs = "<space>ic", desc = "close issue" },
            reopen_issue = { lhs = "<space>io", desc = "reopen issue" },
            list_issues = { lhs = "<space>il", desc = "list open issues on same repo" },
            reload = { lhs = "<C-r>", desc = "reload issue" },
            open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
            copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
            add_assignee = { lhs = "<space>aa", desc = "add assignee" },
            remove_assignee = { lhs = "<space>ad", desc = "remove assignee" },
            create_label = { lhs = "<space>lc", desc = "create label" },
            add_label = { lhs = "<space>la", desc = "add label" },
            remove_label = { lhs = "<space>ld", desc = "remove label" },
            goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
            add_comment = { lhs = "<space>ca", desc = "add comment" },
            delete_comment = { lhs = "<space>cd", desc = "delete comment" },
            next_comment = { lhs = "]c", desc = "go to next comment" },
            prev_comment = { lhs = "[c", desc = "go to previous comment" },
            react_hooray = { lhs = "<space>orp", desc = "add/remove 🎉 reaction" },
            react_heart = { lhs = "<space>orh", desc = "add/remove ❤️ reaction" },
            react_eyes = { lhs = "<space>ore", desc = "add/remove 👀 reaction" },
            react_thumbs_up = { lhs = "<space>or+", desc = "add/remove 👍 reaction" },
            react_thumbs_down = { lhs = "<space>or-", desc = "add/remove 👎 reaction" },
            react_rocket = { lhs = "<space>orr", desc = "add/remove 🚀 reaction" },
            react_laugh = { lhs = "<space>orl", desc = "add/remove 😄 reaction" },
            react_confused = { lhs = "<space>orc", desc = "add/remove 😕 reaction" },
          },
          pull_request = {
            add_assignee = { lhs = "<space>opaa", desc = "add assignee" },
            add_comment = { lhs = "<space>opc", desc = "add comment" },
            add_label = { lhs = "<space>la", desc = "add label" },
            add_reviewer = { lhs = "<space>opar", desc = "add reviewer" },
            checkout_pr = { lhs = "<space>opo", desc = "checkout PR" },
            close_issue = { lhs = "<space>ic", desc = "close PR" },
            copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
            create_label = { lhs = "<space>lc", desc = "create label" },
            delete_comment = { lhs = "<space>opd", desc = "delete comment" },
            goto_file = { lhs = "gf", desc = "go to file" },
            goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
            list_changed_files = { lhs = "<space>opf", desc = "list PR changed files" },
            list_commits = { lhs = "<space>opC", desc = "list PR commits" },
            list_issues = { lhs = "<space>il", desc = "list open issues on same repo" },
            merge_pr = { lhs = "<space>opm", desc = "merge commit PR" },
            next_comment = { lhs = "]c", desc = "go to next comment" },
            open_in_browser = { lhs = "<space>opO", desc = "open PR in browser" },
            prev_comment = { lhs = "[c", desc = "go to previous comment" },
            react_confused = { lhs = "<space>orc", desc = "add/remove 😕 reaction" },
            react_eyes = { lhs = "<space>ore", desc = "add/remove 👀 reaction" },
            react_heart = { lhs = "<space>orh", desc = "add/remove ❤️ reaction" },
            react_hooray = { lhs = "<space>orp", desc = "add/remove 🎉 reaction" },
            react_laugh = { lhs = "<space>orl", desc = "add/remove 😄 reaction" },
            react_rocket = { lhs = "<space>orr", desc = "add/remove 🚀 reaction" },
            react_thumbs_down = { lhs = "<space>or-", desc = "add/remove 👎 reaction" },
            react_thumbs_up = { lhs = "<space>or+", desc = "add/remove 👍 reaction" },
            reload = { lhs = "<C-r>", desc = "reload PR" },
            remove_assignee = { lhs = "<space>opaA", desc = "remove assignee" },
            remove_label = { lhs = "<space>ld", desc = "remove label" },
            remove_reviewer = { lhs = "<space>opaR", desc = "remove reviewer request" },
            reopen_issue = { lhs = "<space>io", desc = "reopen PR" },
            review_resume = { lhs = "<space>oprr", desc = "resume a pending review of PR" },
            review_start = { lhs = "<space>oprs", desc = "start review of PR" },
            show_pr_diff = { lhs = "<space>opD", desc = "show PR diff" },
            squash_and_merge_pr = { lhs = "<space>opsm", desc = "squash and merge PR" },
          },
          review_thread = {
            submit_review = { lhs = "<space>ops", desc = "submit review" },
            add_comment = { lhs = "<space>opc", desc = "add comment" },
            add_suggestion = { lhs = "<space>sa", desc = "add suggestion" },
            close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
            delete_comment = { lhs = "<space>cd", desc = "delete comment" },
            goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
            next_comment = { lhs = "]c", desc = "go to next comment" },
            prev_comment = { lhs = "[c", desc = "go to previous comment" },
            react_confused = { lhs = "<space>orc", desc = "add/remove 😕 reaction" },
            react_eyes = { lhs = "<space>ore", desc = "add/remove 👀 reaction" },
            react_heart = { lhs = "<space>orh", desc = "add/remove ❤️ reaction" },
            react_hooray = { lhs = "<space>orp", desc = "add/remove 🎉 reaction" },
            react_laugh = { lhs = "<space>orl", desc = "add/remove 😄 reaction" },
            react_rocket = { lhs = "<space>orr", desc = "add/remove 🚀 reaction" },
            react_thumbs_down = { lhs = "<space>or-", desc = "add/remove 👎 reaction" },
            react_thumbs_up = { lhs = "<space>or+", desc = "add/remove 👍 reaction" },
            select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
            select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
          },
          -- submit_win = {
          --   approve_review = { lhs = "", desc = "approve review" },
          --   comment_review = { lhs = "space>prc", desc = "comment review" },
          --   request_changes = { lhs = "space>prr", desc = "request changes review" },
          --   close_review_tab = { lhs = "space>prc", desc = "close review tab" },
          -- },
          review_diff = {
            add_review_comment = { lhs = "<space>opc", desc = "add a new review comment" },
            add_review_suggestion = { lhs = "<space>sa", desc = "add a new review suggestion" },
            close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
            focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
            goto_file = { lhs = "gf", desc = "go to file" },
            next_thread = { lhs = "]t", desc = "move to next thread" },
            prev_thread = { lhs = "[t", desc = "move to previous thread" },
            select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
            select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
            toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
            toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
          },
          file_panel = {
            next_entry = { lhs = "j", desc = "move to next changed file" },
            prev_entry = { lhs = "k", desc = "move to previous changed file" },
            select_entry = { lhs = "<cr>", desc = "show selected changed file diffs" },
            refresh_files = { lhs = "R", desc = "refresh changed files panel" },
            focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
            toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
            select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
            select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
            close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
            toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
          },
        },
      })
    end,
  },
}

-- | Object   | Action                                  | Arguments                                                       |
-- | -------- | --------------------------------------- | ----------------------------------------------------------------|
-- | issue    | close                                   | Close the current issue                                         |
-- |          | reopen                                  | Reopen the current issue                                        |
-- |          | create [repo]                           | Creates a new issue in the current or specified repo            |
-- |          | edit [repo] <number>                    | Edit issue `<number>` in current or specified repo              |
-- |          | list [repo] [key=value] (1)             | List all issues satisfying given filter                         |
-- |          | search                                  | Live issue search                                               |
-- |          | reload                                  | Reload issue. Same as doing `e!`                                |
-- |          | browser                                 | Open current issue in the browser                               |
-- |          | url                                     | Copies the URL of the current issue to the system clipboard     |
-- | pr       | list [repo] [key=value] (2)             | List all PRs satisfying given filter                            |
-- |          | search                                  | Live issue search                                               |
-- |          | edit [repo] <number>                    | Edit PR `<number>` in current or specified repo                 |
-- |          | reopen                                  | Reopen the current PR                                           |
-- |          | create                                  | Creates a new PR for the current branch                         |
-- |          | close                                   | Close the current PR                                            |
-- |          | checkout                                | Checkout PR                                                     |
-- |          | commits                                 | List all PR commits                                             |
-- |          | changes                                 | Show all PR changes (diff hunks)                                |
-- |          | diff                                    | Show PR diff                                                    |
-- |          | merge [commit\|rebase\|squash] [delete] | Merge current PR using the specified method                     |
-- |          | ready                                   | Mark a draft PR as ready for review                             |
-- |          | draft                                   | Send a ready PR back to draft                                   |
-- |          | checks                                  | Show the status of all checks run on the PR                     |
-- |          | reload                                  | Reload PR. Same as doing `e!`                                   |
-- |          | browser                                 | Open current PR in the browser                                  |
-- |          | url                                     | Copies the URL of the current PR to the system clipboard        |
-- | repo     | list (3)                                | List repos user owns, contributes or belong to                  |
-- |          | fork                                    | Fork repo                                                       |
-- |          | browser                                 | Open current repo in the browser                                |
-- |          | url                                     | Copies the URL of the current repo to the system clipboard      |
-- |          | view                                    | Open a repo by path ({organization}/{name})                     |
-- | gist     | list [repo] [key=value] (4)             | List user gists                                                 |
-- | comment  | add                                     | Add a new comment                                               |
-- |          | delete                                  | Delete a comment                                                |
-- | thread   | resolve                                 | Mark a review thread as resolved                                |
-- |          | unresolve                               | Mark a review thread as unresolved                              |
-- | label    | add [label]                             | Add a label from available label menu                           |
-- |          | remove [label]                          | Remove a label                                                  |
-- |          | create [label]                          | Create a new label                                              |
-- | assignee | add [login]                             | Assign a user                                                   |
-- |          | remove [login]                          | Unassign a user                                                 |
-- | reviewer | add [login]                             | Assign a PR reviewer                                            |
-- | reaction | `thumbs_up` \| `+1`                     | Add 👍 reaction                                                 |
-- |          | `thumbs_down` \| `-1`                   | Add 👎 reaction                                                 |
-- |          | `eyes`                                  | Add 👀 reaction                                                 |
-- |          | `laugh`                                 | Add 😄 reaction                                                 |
-- |          | `confused`                              | Add 😕 reaction                                                 |
-- |          | `rocket`                                | Add 🚀 reaction                                                 |
-- |          | `heart`                                 | Add ❤️ reaction                                                  |
-- |          | `hooray` \| `party` \| `tada`           | Add 🎉 reaction                                                 |
-- | card     | add                                     | Assign issue/PR to a project new card                           |
-- |          | remove                                  | Delete project card                                             |
-- |          | move                                    | Move project card to different project/column                   |
-- | review   | start                                   | Start a new review                                              |
-- |          | submit                                  | Submit the review                                               |
-- |          | resume                                  | Edit a pending review for current PR                            |
-- |          | discard                                 | Deletes a pending review for current PR if any                  |
-- |          | comments                                | View pending review comments                                    |
-- |          | commit                                  | Pick a specific commit to review                                |
-- |          | close                                   | Close the review window and return to the PR                    |
-- | actions  |                                         | Lists all available Octo actions                                |
-- | search   | <query>                                 | Search GitHub for issues and PRs matching the  |
