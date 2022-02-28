from flask import Flask
import requests

apiKey = 'PUT YOUR API KEY HERE'

app = Flask(__name__)

@app.route('/articles/<period>', methods=['GET'])
def fetchArticles(period):
    url = f'https://api.nytimes.com/svc/mostpopular/v2/viewed/{period}.json?api-key={apiKey}'
    response = requests.get(url)
    return response.text

if __name__ == '__main__':
    app.run()
