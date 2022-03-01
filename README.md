# PomeloTest
This is Kittisak's Pomelo challenge project. The project is built by latest tecnologies from Apple; SwiftUI and Async-Await with zero dependency. Most of the codes are covered by unit test.

## Prerequisites
### Client
* Xcode 13.2.1
* Swift 5.5
* Python 3.x

### Server
* Flask
* Requests

## Step to run the project
1. Install `Flask`

```
$ pip3 install -U Flask
```

2. Install `Requests`

```
$ python3 -m pip install requests
```

3. Go to `PomeloTest` root folder

```
$ cd PomeloTest
```

4. Open `api.py` and change api key to your api key. You can get your api key from [https://developer.nytimes.com](https://developer.nytimes.com)

```
apiKey = 'YOUR API KEY'
```

5. Run localhost server

```
$ python3 api.py
```

You should see the below commands to indicate that the server is running properly. The default port should be 5000

```
* Serving Flask app 'api' (lazy loading)
 * Environment: production
   WARNING: This is a development server. Do not use it in a production deployment.
   Use a production WSGI server instead.
 * Debug mode: off
 * Running on http://127.0.0.1:5000/ (Press CTRL+C to quit)
```

If your localhost is running on different port. Do not forgot to change port number in `ArticleListContentView+ViewModel.swift` to be the same with your port as well.

```
let urlString = "http://127.0.0.1:<YOUR PORT>/articles/\(period.valueInDay)"
```

6. Open `PomeloTest.xcodeproj` and enjoy your time!

## License
PomeloTest is released under the MIT license. See [LICENSE](LICENSE) details.