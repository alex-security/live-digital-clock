"""Time API routes."""

from fastapi import APIRouter, HTTPException, Query, status

from app.services.clock import InvalidTimezoneError, get_time

router = APIRouter(prefix="/api", tags=["time"])


@router.get("/time")
def read_time(timezone: str = Query("Local Time", description="IANA timezone name")) -> dict[str, str]:
    try:
        return get_time(timezone)
    except InvalidTimezoneError as error:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail=str(error)) from error

