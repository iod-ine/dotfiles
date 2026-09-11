import os
from typing import Literal

import requests


def get_execution_state(workflow_id: str, instance_id: str) -> dict:
    """Call Nirvana API to check the execution state of a workflow."""
    response = requests.post(
        url="https://nirvana.yandex-team.ru/api/public/v1/getExecutionState",
        headers={
            "Authorization": f"OAuth {os.environ.get('NIRVANA_TOKEN')}",
            "Content-Type": "application/json; charset=utf-8",
        },
        json={
            "jsonrpc": "2.0",
            "method": "getExecutionState",
            "id": 1,
            "params": {
                "workflowId": workflow_id,
                "workflowInstanceId": instance_id,
            },
        },
        timeout=(30, 30),
    )
    return response.json()


def find_workflows(
    nsPath: str | None = None,
    status: list[Literal["waiting", "running", "completed", "undefined", "scheduled"]] | None = None,
) -> dict:
    filters = {
        k: v
        for k, v in {
            "nsPath": nsPath,
            "status": status,
        }.items()
        if v is not None
    }
    response = requests.post(
        url="https://nirvana.yandex-team.ru/api/public/v1/findWorkflows",
        headers={
            "Authorization": f"OAuth {os.environ.get('NIRVANA_TOKEN')}",
            "Content-Type": "application/json; charset=utf-8",
        },
        json={
            "jsonrpc": "2.0",
            "method": "findWorkflows",
            "id": 1,
            "params": {
                "additionalFilters": filters,
            },
        },
        timeout=(30, 30),
    )
    return response.json()
