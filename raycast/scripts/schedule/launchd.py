"""Code for handling launchd jobs."""

import os
import subprocess
import plistlib
from pathlib import Path


AGENTS_DIR = Path("~/Library/LaunchAgents").expanduser()


def create_launchd_job(label: str, cmd: list[str], interval: int = 120) -> None:
    """Create and load a launchd job."""
    if _job_exists(label):
        remove_launchd_job(label)
    AGENTS_DIR.mkdir(parents=True, exist_ok=True)
    job_dict = {
        "Label": label,
        "ProgramArguments": cmd,
        "RunAtLoad": True,
        "StartInterval": interval,
        "EnvironmentVariables": {"PATH": os.environ.get("PATH", "")},
        "StandardOutPath": "/tmp/watch-nirvana-stdout.txt",
        "StandardErrorPath": "/tmp/watch-nirvana-stderr.txt",
    }
    job_file = AGENTS_DIR / f"{label}.plist"
    with open(job_file, "wb") as f:
        plistlib.dump(job_dict, f, fmt=plistlib.FMT_XML)
    _load_job(job_file)


def remove_launchd_job(label: str) -> None:
    """Remove a launchd job and its .plist file."""
    (AGENTS_DIR / f"{label}.plist").unlink(missing_ok=True)
    if _job_exists(label):
        _remove_job(label)


def _job_exists(label: str) -> bool:
    """Check whether a job with a specified label already exists."""
    return subprocess.run(["launchctl", "list", label], capture_output=True).returncode == 0


def _load_job(job_file: Path) -> None:
    """Load a job from a file."""
    subprocess.run(["launchctl", "load", job_file], check=True)


def _unload_job(job_file: Path) -> None:
    """Unload a job from a file.

    Notes:
        `launchctl unload <job.plist>` also sends a SIGTEM to the running process, so if a script tries to clean itself
        up, it will exit the moment it calls this.
    """
    subprocess.run(["launchctl", "unload", job_file], check=True)


def _remove_job(label: str) -> None:
    """Remove a loaded job."""
    subprocess.run(["launchctl", "remove", label], check=True)
