import requests
import json

response = requests.get('https://ajax.googleapis.com/ajax/services/search/web?v=1.0&q=test+search+query')
print(response.status_code)
print(response.headers)
print(response.text)