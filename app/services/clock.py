"""Clock business logic and supported timezone handling."""

from datetime import datetime
from zoneinfo import ZoneInfo, ZoneInfoNotFoundError


LOCAL_TIMEZONE = "Local Time"
SUPPORTED_TIMEZONES = (
    LOCAL_TIMEZONE,
    "UTC",
    "Asia/Tehran",
    "Asia/Baku",
    "Europe/London",
    "America/New_York",
    "Asia/Tokyo",
)


class InvalidTimezoneError(ValueError):
    """Raised when a requested timezone is not supported or cannot be loaded."""


def get_time(timezone: str) -> dict[str, str]:
    """Return the current clock values for a supported timezone."""
    if timezone not in SUPPORTED_TIMEZONES:
        raise InvalidTimezoneError(f"Unsupported timezone: {timezone}")

    current = datetime.now().astimezone() if timezone == LOCAL_TIMEZONE else datetime.now(ZoneInfo(timezone))
    return {
        "timezone": timezone,
        "time": current.strftime("%H:%M:%S"),
        "date": current.strftime("%Y-%m-%d"),
        "timestamp": current.isoformat(timespec="seconds"),
    }

