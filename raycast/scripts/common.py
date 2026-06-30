import subprocess


def notify(message: str):
    """Send a system notification using osascript."""
    subprocess.run(
        [
            "osascript",
            "-e",
            f'display notification "{message}" with title "Graph watchdog" sound name "Glass"',
        ]
    )
