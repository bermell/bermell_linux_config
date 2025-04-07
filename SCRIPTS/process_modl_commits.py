#!/usr/bin/env python3
import argparse
import re
import subprocess
from typing import Optional


def get_git_commits(n):
    """
    Run the git log command to fetch the last n commit summaries.
    Using --pretty=%s prints only the commit summary.

    Reference: "git log" documentation (https://git-scm.com/docs/git-log)
    """
    result = subprocess.check_output(
        ["git", "log", "-n", str(n), "--pretty=%s"], text=True
    )
    return result.splitlines()


def process_commits(commits):
    """
    Process commit messages as follows:
      - If a commit matches "[skip ci] Version Bumped to <version>"
        and is immediately followed by a merge commit,
        output "<version> <merge commit message>".
      - Ignore any other commits that start with "[skip ci]".
      - Output all other commits as-is.

    This demonstrates text parsing and pattern matching using Python's 're' module.
    See: https://docs.python.org/3/library/re.html
    """
    output = []
    current_version: Optional[str] = None
    for commit in commits:
        if not current_version:
            # we go look for a current version
            match_version = re.match(r"\[skip ci\].*?(\d+\.\d+\.\d+)", commit)
            if match_version:
                current_version = match_version.group(1)
        elif not commit.startswith("[skip ci]"):
            output.append(f"{current_version} {commit}")
            current_version = None

    return output


def main(n):
    commits = get_git_commits(n)
    processed_commits = process_commits(commits)
    # Print each processed commit message.
    for commit in processed_commits:
        print(commit)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Display git log with version numbers for merge commits."
    )
    parser.add_argument(
        "-n", type=int, default=30, help="Number of commits to show (default: 30)"
    )
    args = parser.parse_args()
    main(args.n)
