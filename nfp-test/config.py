import os
from dotenv import load_dotenv

load_dotenv()

class Config:
    API_URL = os.getenv("API_URL")

config = Config()