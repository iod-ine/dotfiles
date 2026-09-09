#!/Users/ivandubrovin/.dotfiles/raycast/scripts/.venv/bin/python

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Start CL for branch
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "name" }

import re
import sys
from pathlib import Path

import dotenv
import pyperclip

from api.domain_constructor import start_process

CLOSED_LOOP_WITH_RAIL_AGENTS_SCHEMA_ID = 26902


if __name__ == "__main__":
    if not dotenv.load_dotenv(dotenv_path=Path(__file__).parent / ".env"):
        print("Could not load the .env file.")
        sys.exit(1)

    branch = pyperclip.paste()

    branch_name_regex = re.compile(r"^(?:users|tags/releases/.*)/[a-zA-Z0-9\-_]*/[a-zA-Z0-9\-_]*")
    if branch_name_regex.match(branch) is None:
        print(f"Branch name format is incorrect: {branch}")
        sys.exit(1)

    process_name = sys.argv[1] or branch

    for safety_mode, selection_policy in (("profile", "profile"), ("disabled", "ml")):
        response: dict = start_process(
            schema_id=CLOSED_LOOP_WITH_RAIL_AGENTS_SCHEMA_ID,
            name=process_name,
            pipeline_commit=branch,
            safety_mode=safety_mode,
            selection_policy=selection_policy,
            run_routing=False,
        )
        if (error := response.get("error")) is not None:
            print(error)
            sys.exit(1)

    print(f"Started two CL runs for {branch}.")
