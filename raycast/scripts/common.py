import subprocess


def notify(
    message: str,
    *,
    title: str = "Terminal",
    sound: str = "Glass",
    url: str | None = None,
):
    """Send a system notification using terminal-notifier."""
    cmd = [
        "terminal-notifier",
        "-message",
        message,
        "-title",
        title,
        "-sound",
        sound,
    ]
    if url is not None:
        cmd.extend(["-open", url])
    subprocess.run(cmd)
