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
        logger.add("/tmp/watch-nirvana-graph.log", level="INFO", rotation="10 MB")
        workflow_id, instance_id, graph_label = sys.argv[2], sys.argv[3], sys.argv[4]
        response: dict = get_execution_state(workflow_id, instance_id)
        if (error := response.get("error")) is not None:
            remove_launchd_job(label=f"local.watch-nirvana-graph.{instance_id}")
            message = error.get("message") or "no message provided"
            notify(
                f"API error when polling graph[{graph_label}]: '{message}'",
                url=make_nirvana_graph_url(workflow_id, instance_id),
            )
            logger.error(f"API error when polling graph[{graph_label}] with {instance_id=}: '{message}'")
            sys.exit(1)
        status = response["result"]["status"]
        logger.info(f"Poll result: {status=} for graph with {instance_id=}")
        if status != "running":
            remove_launchd_job(label=f"local.watch-nirvana-graph.{instance_id}")
            notify(
                f"Graph[{graph_label}] finished with status '{status}'",
                url=make_nirvana_graph_url(workflow_id, instance_id),
            )
    else:
        try:
            workflow_id, instance_id = parse_nirvana_url_from_clipboard()
        except IndexError:
            print("Could not parse the Nirvana URL.")
            sys.exit(1)
        graph_label = sys.argv[1] if len(sys.argv) > 1 else "unlabeled"
        create_launchd_job(
            label=f"local.watch-nirvana-graph.{instance_id}",
            cmd=[sys.executable, __file__, "--background", workflow_id, instance_id, graph_label],
            interval=120,
        )
        print("Created a watch job.")
