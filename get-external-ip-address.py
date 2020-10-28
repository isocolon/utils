import requests


def GetMyExternalIPAddress():
    '''
    Query a few external services to get our external IP address
    '''
    urls = [
            'https://api.ipify.org',
            'https://ident.me',
            'https://checkip.amazonaws.com',
            # 'https://ipapi.co/ip/' -> appears to be rate limited
            ]
    ip1 = [ requests.get(url).text.strip() for url in urls ]
    ip2 = [ requests.get('https://www.wikipedia.org').headers['X-Client-IP'] ]

    return ip1 + ip2

print(GetMyExternalIPAddress())
