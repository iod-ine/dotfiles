#!/Users/ivandubrovin/.dotfiles/raycast/scripts/.venv/bin/python

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title inference-time-statistics-from-log-url
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "log url" }

import hashlib
import pathlib
import re
import sys

import numpy as np
import requests
import seaborn as sns
from termcolor import colored

url = sys.argv[1]
regex = re.compile(r"TimeLogger '/MlPlannerInference' .+ finished in (\d+) us")

r = requests.get(url)
r.raise_for_status()

print(f"Fetched logs from {url}", end="\n\n")

times = np.array([int(x) / 1000 for x in regex.findall(r.content.decode())])

print(colored(f"/MlPlannerInference statistics (ms, n={times.size}):", "red", force_color=True))
print(f"  mean: {times.mean():>8.3f}")
print(f"   std: {times.std():>8.03f}")
print(f"   q50: {np.quantile(times, 0.50):>8.03f}")
print(f"   q95: {np.quantile(times, 0.95):>8.03f}")
print(f"   q99: {np.quantile(times, 0.99):>8.03f}")
print(f"   max: {times.max():>8.03f}")

sha1 = hashlib.sha1(url.encode()).hexdigest()[:7]
image_dir = pathlib.Path(f"/tmp/inference_times/{sha1}")
image_dir.mkdir(parents=True, exist_ok=True)
image_path = image_dir / "hist.png"

ax = sns.histplot(times)
ax.figure.savefig(str(image_path))

print(f"\nSaved histogram to {image_path}")
