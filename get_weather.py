#!/usr/bin/env python3
import os, re
from urllib.request import urlopen

def get_ip_city():
    try:
        with urlopen('https://ipinfo.io/city', timeout=3) as resp:
            return resp.read().decode().strip().replace(' ', '+')
    except Exception:
        return None

def fetch_weather(location):
    url = f'https://wttr.in/{location}?format=%l:+%C,+%t'
    try:
        with urlopen(url, timeout=5) as resp:
            return resp.read().decode().strip()
    except Exception:
        return None

jarvis_location = os.environ.get('JARVIS_LOCATION', '').strip()
location = jarvis_location.replace(' ', '+') if jarvis_location else get_ip_city()

if location:
    weather = fetch_weather(location)
    if weather:
        print(weather)
