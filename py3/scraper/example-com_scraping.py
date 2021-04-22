#!/usr/bin/env python3
import requests
from bs4 import BeautifulSoup

r = requests.get('http://example.com')
soup = BeautifulSoup(r.text, "html.parser")

print(soup.h1.string)
# Example Domain

print(soup.a["href"])
# http://www.iana.org/domains/example

absaetze = soup.find_all('p') # Speichert alle Absätze als Liste
