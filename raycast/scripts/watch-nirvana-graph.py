#!/Users/ivandubrovin/.dotfiles/raycast/scripts/.venv/bin/python

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title watch-nirvana-graph
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

import time
import re
import sys
import subprocess

import dotenv
import pyperclip

from loguru import logger

from api.nirvana import get_execution_state
from common import notify


def parse_nirvana_url_from_clipboard() -> tuple[str, str]:
    """Parse a Nirvana graph URL from clipboards into workflow and instance IDs."""
    url = pyperclip.paste()
    regex = re.compile(r"nirvana.yandex-team.ru/flow/([^/]+)/([^/]+)/graph")
    return regex.findall(url)[0]


def watch_instance(
    workflow_id: str,
    instance_id: str,
    *,
    delay: int = 60,
    timeout: int = 21600,
) -> str:
    """Watch a running Nirvana graph instance and get its status when it finishes."""
    logger.add("/tmp/watch-nirvana-graph.log", level="INFO", rotation="10 MB")
    logger.info(f"Started watching graph with {instance_id=}")
    start_time = time.time()
    while time.time() - start_time < timeout:
        execution_state = get_execution_state(workflow_id, instance_id)
        status = execution_state["result"]["status"]
        logger.info(f"Poll result: {status=} for graph with {instance_id=}")
        if status != "running":
            logger.info(f"Instance {instance_id} finished with {status=}")
            return status
        time.sleep(delay)
    logger.warning(f"Timeout exceeded for graph with {instance_id=}")
    raise TimeoutError


if __name__ == "__main__":
    if not dotenv.load_dotenv():
        print("Could not load the .env file.")
        sys.exit(1)
    if len(sys.argv) > 1 and sys.argv[1] == "--run-background":
        try:
            workflow_id, instance_id = sys.argv[2], sys.argv[3]
            status = watch_instance(workflow_id, instance_id)
            notify(f"Graph finished with status '{status}'")
        except TimeoutError:
            notify("Timeout exceeded. No longer watching the instance.")
    else:
        try:
            workflow_id, instance_id = parse_nirvana_url_from_clipboard()
        except IndexError:
            print("Could not parse the Nirvana URL.")
            sys.exit(1)
        subprocess.Popen(
            [sys.executable, __file__, "--run-background", workflow_id, instance_id],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
            stdin=subprocess.DEVNULL,
            start_new_session=True,
        )
        print("Started the watch process.")
