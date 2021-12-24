import requests
from config import config


def test_get_notes():
    r = requests.get(f'{config.API_URL}/notes/')
    assert r.status_code == 200

def test_post_note():
    payload = {"text": "hello world", "completed": False}
    r = requests.post(f'{config.API_URL}/notes/', json=payload)
    assert r.status_code == 200
