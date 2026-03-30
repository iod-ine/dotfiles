#!/Users/ivandubrovin/.dotfiles/raycast/scripts/.venv/bin/python

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search rides from clipboard
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description Parse the clipboard for ride details and open a search page


import re
import sys
import urllib.parse
import webbrowser

import pyperclip

rover_name_regex = re.compile(r"a\d{3,}")
date_regex = re.compile(r"\d{4}-\d\d-\d\d")
time_regex = re.compile(r"\d\d:\d\d")

context = pyperclip.paste()

if len(context) == 0:
    print("The clipboard is empty.")
    sys.exit(1)

params = {}

rover_name = rover_name_regex.findall(context)
date = date_regex.findall(context)
time = time_regex.findall(context)

if rover_name:
    params["roverName"] = rover_name[0]

if date:
    params["dateFrom"] = date[0]
    params["dateTo"] = date[0]

if params:
    base_url = "https://analytic-services.sdc.yandex-team.ru/rides"
    query = urllib.parse.urlencode(params)
    webbrowser.open(f"{base_url}?{query}")

    if time:
        print(f"Approximate time: {time[0]}")
else:
    print("Could not extract search parameters from the clipboard.")
    sys.exit(1)
