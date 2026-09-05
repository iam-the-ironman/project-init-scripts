import pytest

from notes import add_note, delete_note, search_notes


def test_add_note_assigns_incrementing_ids():
    notes = []
    assert add_note(notes, "buy milk") == 1
    assert add_note(notes, "call the dentist") == 2
    assert notes[1]["text"] == "call the dentist"


def test_add_note_rejects_empty_text():
    with pytest.raises(ValueError):
        add_note([], "   ")


def test_delete_note_removes_the_right_note():
    notes = []
    add_note(notes, "keep me")
    doomed = add_note(notes, "remove me")
    assert delete_note(notes, doomed) is True
    assert len(notes) == 1
    assert notes[0]["text"] == "keep me"


def test_delete_note_returns_false_for_missing_id():
    assert delete_note([], 42) is False


def test_search_is_case_insensitive():
    notes = []
    add_note(notes, "Renew the TLS certificate")
    add_note(notes, "water the plants")
    found = search_notes(notes, "tls")
    assert len(found) == 1
    assert found[0]["text"] == "Renew the TLS certificate"
