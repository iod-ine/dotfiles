#!/Users/ivandubrovin/.dotfiles/raycast/scripts/.venv/bin/python

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title watch-nirvana-graph
# @raycast.mode compact
# @raycast.argument1 { "type": "text", "placeholder": "Label [optional]", "optional": true }

# Optional parameters:
# @raycast.icon 👀

import sys
from pathlib import Path

import dotenv
from loguru import logger

from api.nirvana import get_execution_state
from common import notify
from urls.nirvana import make_nirvana_graph_url, parse_nirvana_url_from_clipboard
from schedule.launchd import create_launchd_job, remove_launchd_job


if __name__ == "__main__":
    if not dotenv.load_dotenv(dotenv_path=Path(__file__).parent / ".env"):
        print("Could not load the .env file.")
        sys.exit(1)

    if len(sys.argv) > 1 and sys.argv[1] == "--background":
        # This branch is executed when invoked by launchd.
        workflow_id, instance_id, graph_label = sys.argv[2], sys.argv[3], sys.argv[4]
        response: dict = get_execution_state(workflow_id, instance_id)

        labeled_graph = f"graph[{graph_label}]" if graph_label else "graph"

        if (error := response.get("error")) is not None:
            message = error.get("message", "no error message provided")
            notify(
                f"API error when polling {labeled_graph}: {message=}",
                url=make_nirvana_graph_url(workflow_id, instance_id),
                sound="Sosumi",
            )
            logger.error(f"API error with {message=} when polling {instance_id=}")

            # This will force a SIGTERM on self, the exit is simply a guard and to clarify intent.
            remove_launchd_job(label=f"local.watch-nirvana-graph.{instance_id}")
            sys.exit(1)

        status = response["result"]["status"]
        result = response["result"]["result"]
        logger.info(f"{instance_id=} {status=} {result=}")
        if status != "running":
            notify(
                f"{labeled_graph.capitalize()} finished with {result=}",
                url=make_nirvana_graph_url(workflow_id, instance_id),
                sound="Purr" if result == "success" else "Sosumi",
            )
            # This will force a SIGTERM on self, the exit is simply a guard and to clarify intent.
            remove_launchd_job(label=f"local.watch-nirvana-graph.{instance_id}")
            sys.exit()
    else:
        # This branch is executed when invoked by Raycast.
        try:
            workflow_id, instance_id = parse_nirvana_url_from_clipboard()
        except IndexError:
            print("Could not parse the Nirvana URL.")
            sys.exit(1)

        # Check once before creating a launchd job
        response: dict = get_execution_state(workflow_id, instance_id)
        if (error := response.get("error")) is not None:
            message = error.get("message", "no error message provided")
            print(f"API error with {message=}")
            sys.exit(1)
        if (status := response["result"]["status"]) != "running":
            result = response["result"]["result"]
            print(f"Graph already finished with {result=}")
            sys.exit()

        graph_label = sys.argv[1]

        # If still running, create a launchd watcher job
        create_launchd_job(
            label=f"local.watch-nirvana-graph.{instance_id}",
            cmd=[sys.executable, __file__, "--background", workflow_id, instance_id, graph_label],
            interval=120,
            run_at_load=False,
        )
        print("Graph is running. Created a launchd watcher job.")
