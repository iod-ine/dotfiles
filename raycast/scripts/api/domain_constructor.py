import os

import requests


def start_process(schema_id: int, name: str, **kwargs) -> dict:
    response = requests.post(
        url="https://domains-int.yandex-team.ru/api/public/v1/startProcess",
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


def get_process_state(process_id: int) -> dict:
    response = requests.post(
        url="https://domains-int.yandex-team.ru/api/public/v1/getProcessState",
        headers={
            "Authorization": f"OAuth {os.environ.get('NIRVANA_TOKEN')}",
            "Content-Type": "application/json; charset=utf-8",
        },
        json={
            "jsonrpc": "2.0",
            "method": "getProcessState",
            "id": 1,
            "params": {"processId": process_id},
        },
    )
    return response.json()
