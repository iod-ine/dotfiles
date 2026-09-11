import re

import pyperclip

_yql_operation_url_regex = re.compile(r"yql.yandex-team.ru/Operations/([a-zA-Z0-9\-_=]+)")


def parse_yql_operation_url_from_clipboard() -> str:
    """Parse a YQL operation URL from clipboard into its operation ID."""
    url = pyperclip.paste()
    return _yql_operation_url_regex.findall(url)[0]


def make_yql_operation_url(operation_id: str) -> str:
    """Construct a YQL operation URL from its ID."""
    return f"https://yql.yandex-team.ru/Operations/{operation_id}"
