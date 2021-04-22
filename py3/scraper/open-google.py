#!/usr/bin/env python3

from selenium import webdriver

DRIVER_PATH = '/home/lukas/prog/playground/py3/scraper/chromedriver'
driver = webdriver.Chrome(executable_path=DRIVER_PATH)
driver.get('https://google.com')
