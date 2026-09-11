import os

import requests


def get_operation_meta(operation_id: str) -> dict:
    """Call YQL API to check the public operation metadata."""
    response = requests.get(
        url=f"https://yql.yandex.net/api/v2/operations/{operation_id}/meta",
        headers={
            "Authorization": f"OAuth {os.environ.get('YQL_TOKEN')}",
            "Content-Type": "application/json; charset=utf-8",
        },
    )
    return response.json()
