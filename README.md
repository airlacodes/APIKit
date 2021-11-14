This framework is a work in progress and not yet ready for use. But anyone is welcome to contribute or use anything they see!

# APIKit
Connect with an API faster

APIKit gives you an object capable of reaching a URL and decoding the response within a few lines of swift.

It utilises the the [codable](https://developer.apple.com/documentation/swift/codable) protocol to encode and decode your request / response models, [URLSession](https://developer.apple.com/documentation/foundation/urlsession) to make the request and a promise / observer to execute or consistently poll an endpoint.

## Features

- Fast, quick and easy way to reach API endpoints
- A quick way to make your own SDK for your API (only worry about defining endpoint paths, request models and response models)
- Supports JWT Bearer authentication (specify if an Endpoint requires authentication, inject refresh token path and token will automatically persist and refresh)
- Request interceptor to add your own headers to any request
- 0 dependencies / extension framework (built on URLSession)
- Flexible (decode error responses with your own models and enrich requests with custom headers)

## Example call

Imagine we need to call [this example rest endpoint](https://jsonplaceholder.typicode.com/posts/1) and print the Post properties to the console.

Firstly, we create a Post struct that conforms to APIModel (allias for Codable) and the schema of the jsonplaceholder.typeicode.com response.

```swift
struct Post: APIModel {
    let userId: Int
    let id: Int
    let title: String
    let body: String


    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case id
        case title
        case body
    }
}
```

And then we can make the call for /post/id: 
```swift

let endpoint = Endpoint(path: "https://jsonplaceholder.typicode.com/posts/1)",
                        method: .get)

let call = APICall<Post>(endpoint: endpoint)

call.execute { response in
    switch response {
        case .success(let post): print("POST: ", post)
        case .failure(let error): print("error: ", error)
    }
}
```

### Turn your networking layer into an SDK

With APIKit you can statically declare your API for the contract that it is.
```swift

struct API {

    static func getPost(id: Int) -> APICall<Post> {
        return APICall<Post>(endpoint: getPostEndpoint(id: id))
    }

    private static func getPostEndpoint(id: Int) -> Endpoint {
        return Endpoint(path: "https://jsonplaceholder.typicode.com/posts/\(id)", method: .get)
    }
}
```

Giving you or your customers strongly typed access to an endpoint
```swift
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        API.getPost(id: 1).execute { response in
            switch response {
            case .success(let post): print("POST: ", post)
            case .failure(let error): print("error: ", error)
            }
        }
    }
}

```

### JWT / Bearer Auth endpoints

Not all endpoints are unprotected. Chances are you need to talk to a backend which implements bearer auth (JWT). This involves handling an access token which could expire and requires refreshing. APIKit has you covered by keeping hold of 'Credentials' in the cache. 

To tell APIKit to add 'Bearer: xxx' to the request header, specify authenticated = true when creating the Endpoint you want to call: 
```swift

let profileEndpoint = Endpoint(path: "https://protectedendpoint.com",
                               method: .post
                               requestPayload: nil,
                               authenticated: true) // note: true / false tells APIKit to add Bearer
                               
let apiCall = APICall<ExpectedResponse>(endpoint: protectedEndpoint)

apiCall.execute { result in
   print(result)
}
```
Now APIKit knows to add a 'Bearer' field and it also knows to refresh. But you may wonder how it knows the refresh token path, access token and refresh token to use.  This can all be supplied to the APIKit singleton both as a setting (refresh token path) and upon successful login.



```swift
//AppDelegate / App start up: let APIKit know a refresh token path

APIKit.refreshTokenPath = "https://my-api/refresh" 

```

As well as a refresh token path, APIKit will also need 'Credentials'. This struct can be supplied to the APIKit singleton upon a successful login call. APIKit uses standard practice in JWT/Bearer auth implementation. So long as your backend auth / refresh endpoints return the following structure and coding keys, APIKit will be able to keep track under the provided 'Credentials' struct:

```swift
{
 access_token: String
 refresh_token: String
 expires_in: Int
}
```
Credentials can be provided to the APIKit singleton after login:

``` swift
// perform login APICall 
let authEndpoint = Endpoint(path: "https://my-api/auth",
                            method: .post,
                            requestPayload: LoginRequest(email: "hi@hi.com", password: "123"),
                            authenticated: false)
                            
let authCall = APICall<Auth>(endpoint: authEndpoint)

authCall.execute { result in
    switch result {
        case .success(let auth):
            let credentials = Credentials(accessToken: auth.accessToken, refreshToken: auth.refreshToken, expiresIn: auth.expiresIn)
            APIKit.credentials = credentials
        default: break
    }
}
```
Now APIKit has a refresh token path and credentials, hhen you specify an endpoint is 'authenticated' moving forward, it will make use of these details to keep authenticated (adding Bearer header + automatic JWT refresh if token is 30 seconds away from expiring). Otherwise it will throw and unauthorised error as a response and you can log your user out accordingly. 

## Observing (polling) TBC

# Roadmap

- SDK design structure inspiration 
- Combine based polling 
