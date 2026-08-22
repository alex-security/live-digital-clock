# Timetime

A small FastAPI application that displays a live digital clock with timezone selection.

## Run

```bash
python -m venv .venv
source .venv/bin/activate  # Windows: .venv\Scripts\activate
pip install -r requirements.txt
uvicorn app.main:app --reload
```

Open http://127.0.0.1:8000.

## Test

```bash
pytest
```
