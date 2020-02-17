import requests
from requests import ReadTimeout


def get_page(url):
    try:
        response = requests.get(url, timeout=1)
        if response.status_code == 200:
            return response.text
        else:
            print('Get Page Failed', response.status_code)
            return None
    except (ConnectionError, ReadTimeout):
        print('Crawling Failed', url)
        return None


def main():
    url = 'https://www.anaconda.com/distribution/#download-section'
    print(get_page(url))


if __name__ == '__main__':
    main()
