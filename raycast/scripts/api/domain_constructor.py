import os

import requests


def start_process(schema_id: int, name: str, **kwargs) -> dict:
    response = requests.post(
        url="https://nirvana.yandex-team.ru/api/dc/public/v1/startProcess",
        headers={
            "Authorization": f"OAuth {os.environ.get('NIRVANA_TOKEN')}",
            "Content-Type": "application/json; charset=utf-8",
        },
        json={
            "jsonrpc": "2.0",
            "method": "startProcess",
            "id": 1,
            "params": {
                "processTemplateSchemaId": schema_id,
                "name": name,
                "params": {
                    "options": [{"absolutePath": k, "value": v} for k, v in kwargs.items()],
                },
            },
        },
    )
    return response.json()
