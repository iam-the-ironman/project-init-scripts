# notekeeper

A tiny notes CLI. Notes are stored in a JSON file next to the
script (or wherever NOTES_FILE points).

## Usage

```bash
python3 notes.py add "buy milk"
python3 notes.py list
python3 notes.py search milk
python3 notes.py delete 1
```

## Run the tests

```bash
python3 -m pip install -r requirements.txt
python3 -m pytest
```
