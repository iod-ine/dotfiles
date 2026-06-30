import os
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
    )
    return response.json()
