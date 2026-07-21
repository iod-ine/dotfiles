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
    }
    job_file = AGENTS_DIR / f"{label}.plist"
    with open(job_file, "wb") as f:
        plistlib.dump(job_dict, f, fmt=plistlib.FMT_XML)
    _load_job(job_file)


def remove_launchd_job(label: str) -> None:
    """Remove a launchd job."""
    job_file = AGENTS_DIR / f"{label}.plist"
    if job_file.exists():
        _unload_job(job_file)
    job_file.unlink(missing_ok=True)


def _job_exists(label: str) -> bool:
    """Check whether a job with a specified label already exists."""
    return subprocess.run(["launchctl", "list", label], capture_output=True).returncode == 0


def _load_job(job_file: Path) -> None:
    """Load a job."""
    subprocess.run(["launchctl", "load", job_file], check=True)


def _unload_job(job_file: Path) -> None:
    """Unload a job."""
    subprocess.run(["launchctl", "unload", job_file], check=True)
