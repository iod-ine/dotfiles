#!/Users/ivandubrovin/.dotfiles/raycast/scripts/.venv/bin/python

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Tracker: response needed
# @raycast.mode inline
# @raycast.refreshTime 1h

# Optional parameters:
# @raycast.icon ⏳

# Documentation:
# @raycast.description Count the amount of tickets waiting a response from me.

import os

import dotenv
import requests

assert dotenv.load_dotenv()

response = requests.post(
    url="https://st-api.yandex-team.ru/v3/issues/_count",
    headers={
        "Authorization": f"OAuth {os.environ.get('TRACKER_TOKEN')}",
        "Host": "st-api.yandex-team.ru",
    },
    json={
        "filter": {
            "pendingReplyFrom": "me()",
        },
    },
)

assert response.ok

count = response.json()

if count == 0:
    print("\033[1;32mNo tickets need a response.\033[0m")
else:
    print(f"{count} ticket[s] are waiting for a response.")
