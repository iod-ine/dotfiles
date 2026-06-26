#!/Users/ivandubrovin/.dotfiles/raycast/scripts/.venv/bin/python

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Parse Nirvana URL
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🤖

import re

import pyperclip
from termcolor import colored

url = pyperclip.paste()
regex = re.compile(r"nirvana.yandex-team.ru/flow/([^/]+)/([^/]+)/graph")

try:
    res = regex.findall(url)[0]
    print(f"  Workflow ID: {res[0]}")
    print(f"  Instance ID: {res[1]}")
except IndexError:
    print(colored("Could not parse the url.", "red", force_color=True))
