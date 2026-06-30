import pyperclip
import re

_nirvana_url_regex = re.compile(r"nirvana.yandex-team.ru/flow/([^/]+)/([^/]+)/graph")


def parse_nirvana_url_from_clipboard() -> tuple[str, str]:
    """Parse a Nirvana graph URL from clipboards into workflow and instance IDs."""
    url = pyperclip.paste()
    return _nirvana_url_regex.findall(url)[0]


def make_nirvana_graph_url(workflow_id: str, instance_id: str) -> str:
    """Construct a Nirvana graph URL from workflow and instance IDs."""
    return f"https://nirvana.yandex-team.ru/flow/{workflow_id}/{instance_id}/graph"
