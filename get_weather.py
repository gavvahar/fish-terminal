#!/usr/bin/env python3
import os, sys
from urllib.request import urlopen

def get_ip_city():
    try:
        with urlopen('https://ipinfo.io/city', timeout=3) as resp:
            return resp.read().decode().strip().replace(' ', '+')
    except Exception:
        return None

def fetch_weather(location):
    url = f'https://wttr.in/{location.replace(" ", "+")}?format=%l:+%C,+%t'
    try:
        with urlopen(url, timeout=5) as resp:
            return resp.read().decode().strip()
    except Exception:
        return None

location = ' '.join(sys.argv[1:]).strip() if len(sys.argv) > 1 else get_ip_city()
if location:
    weather = fetch_weather(location)
    if weather:
        print(weather)
