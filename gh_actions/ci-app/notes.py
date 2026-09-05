"""notekeeper - a tiny notes CLI backed by a JSON file."""
import json
import os
import sys

NOTES_FILE = os.environ.get("NOTES_FILE", "notes.json")


def load_notes(path=None):
    path = path or NOTES_FILE
    if not os.path.exists(path):
        return []
    with open(path) as f:
        return json.load(f)


def save_notes(notes, path=None):
    path = path or NOTES_FILE
    with open(path, "w") as f:
        json.dump(notes, f, indent=2)


def add_note(notes, text):
    text = text.strip()
    if not text:
        raise ValueError("note text cannot be empty")
    note_id = max((n["id"] for n in notes), default=0) + 1
    notes.append({"id": note_id, "text": text})
    return note_id


def delete_note(notes, note_id):
    for i, note in enumerate(notes):
        if note["id"] == note_id:
            notes.pop(i)
            return True
    return False


def search_notes(notes, term):
    term = term.lower()
    return [n for n in notes if term in n["text"].lower()]


def main(argv=None):
    argv = argv if argv is not None else sys.argv[1:]
    if not argv:
        print("usage: notes.py [add TEXT | list | delete ID | search TERM]")
        return 1
    command, args = argv[0], argv[1:]
    notes = load_notes()
    if command == "add":
        note_id = add_note(notes, " ".join(args))
        save_notes(notes)
        print(f"added note {note_id}")
    elif command == "list":
        for note in notes:
            print(f"{note['id']}: {note['text']}")
    elif command == "delete":
        if delete_note(notes, int(args[0])):
            save_notes(notes)
            print("deleted")
        else:
            print("not found")
            return 1
    elif command == "search":
        for note in search_notes(notes, " ".join(args)):
            print(f"{note['id']}: {note['text']}")
    else:
        print(f"unknown command: {command}")
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
