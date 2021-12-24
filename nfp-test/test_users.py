import requests
import string
import random
from config import config

username = None
password = None
token = None

def test_post_users():
    global username
    global password
    username = ''.join(random.sample(string.ascii_letters, 8))
    password = ''.join(random.sample(string.ascii_letters, 8))
    payload = {
        "username": username,
        "password": password
        }
    r = requests.post(f'{config.API_URL}/users/', json=payload)
    assert r.status_code == 200

def test_post_token():
    global token
    payload = {"username": username, "password": password}
    r = requests.post(f'{config.API_URL}/token', data=payload)
    json = r.json()
    token = json['access_token']
    assert r.status_code == 200

def test_get_users_me():
    headers = {'Authorization': f'Bearer {token}'}
    r = requests.get(f'{config.API_URL}/users/me/', headers=headers)
    json = r.json()
    assert json['username'] == username
    assert r.status_code == 200

def test_get_users_me_items():
    headers = {'Authorization': f'Bearer {token}'}
    r = requests.get(f'{config.API_URL}/users/me/items/', headers=headers)
    assert r.status_code == 200
