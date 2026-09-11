#!/Users/ivandubrovin/.dotfiles/raycast/scripts/.venv/bin/python

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title watch-yql-operation
# @raycast.mode compact
# @raycast.argument1 { "type": "text", "placeholder": "Label [optional]", "optional": true }

# Optional parameters:
# @raycast.icon 👀


import sys
from pathlib import Path

import dotenv

from api.yql import get_operation_meta
from common import notify
from schedule.launchd import create_launchd_job, remove_launchd_job
from urls.yql import make_yql_operation_url, parse_yql_operation_url_from_clipboard

if __name__ == "__main__":
    if not dotenv.load_dotenv(dotenv_path=Path(__file__).parent / ".env"):
        print("Could not load the .env file.")
        sys.exit(1)

    if len(sys.argv) > 1 and sys.argv[1] == "--background":
        # This branch is executed when invoked by launchd.
        operation_id, operation_label = sys.argv[2], sys.argv[3]
        response: dict = get_operation_meta(operation_id)

        labeled_operation = f"operation[{operation_label}]" if operation_label else "operation"

        if (message := response.get("message")) is not None:
            notify(
                f"API error when polling {labeled_operation}: {message=}",
                url=make_yql_operation_url(operation_id),
                sound="Sosumi",
            )

            # This will force a SIGTERM on self, the exit is simply a guard and to clarify intent.
            remove_launchd_job(label=f"local.watch-yql-operation.{operation_id}")
            sys.exit(1)

        status = response["status"]
        if status != "RUNNING":
            notify(
                f"{labeled_operation.capitalize()} finished with {status=}",
                url=make_yql_operation_url(operation_id),
                sound="Purr" if status == "COMPLETED" else "Sosumi",
            )
            # This will force a SIGTERM on self, the exit is simply a guard and to clarify intent.
            remove_launchd_job(label=f"local.watch-yql-operation.{operation_id}")
            sys.exit()
    else:
        # This branch is executed when invoked by Raycast.
        try:
            operation_id = parse_yql_operation_url_from_clipboard()
        except IndexError:
            print("Could not parse the YQL URL.")
            sys.exit(1)

        # Check once before creating a launchd job
        response: dict = get_operation_meta(operation_id)
        if (message := response.get("message")) is not None:
            print(f"API error with {message=}")
            sys.exit(1)
        if (status := response["status"]) != "RUNNING":
            print(f"Operation already finished with {status=}")
            sys.exit()

        operation_label = sys.argv[1]

        # If still running, create a launchd watcher job
        create_launchd_job(
            label=f"local.watch-yql-operation.{operation_id}",
            cmd=[sys.executable, __file__, "--background", operation_id, operation_label],
            interval=120,
            run_at_load=False,
        )
        print("Operation is running. Created a launchd watcher job.")
