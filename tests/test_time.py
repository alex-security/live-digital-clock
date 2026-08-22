from fastapi.testclient import TestClient

from app.main import app

client = TestClient(app)


def test_time_endpoint_default_response_structure() -> None:
    response = client.get('/api/time')
    assert response.status_code == 200
    assert set(response.json()) == {'timezone', 'time', 'date', 'timestamp'}


def test_valid_timezone() -> None:
    response = client.get('/api/time', params={'timezone': 'Asia/Baku'})
    assert response.status_code == 200
    assert response.json()['timezone'] == 'Asia/Baku'


def test_invalid_timezone() -> None:
    response = client.get('/api/time', params={'timezone': 'Mars/Olympus'})
    assert response.status_code == 400

