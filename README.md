This framework is a work in progress and not yet ready for use. But anyone is welcome to contribute or use anything they see!

# APIKit
Connect with an API faster

APIKit gives you an object capable of reaching a URL and decoding the response within a few lines of swift.

It utilises the the [codable](https://developer.apple.com/documentation/swift/codable) protocol to encode and decode your request / response models, [URLSession](https://developer.apple.com/documentation/foundation/urlsession) to make the request and a promise / observer to execute or consistently poll an endpoint.

## Aims

- Fast, quick and easy way to reach API endpoints
- Strongly typed API access to buid customised endpoints for SDKs or integrations

## Example call

Imagine we need to call [this example rest endpoint](https://jsonplaceholder.typicode.com/posts/1) and print the Post properties to the console.

Firstly, we create the Post struct that conforms to APIModel (allias for Codable)
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
// create a call       
let endpoint = Endpoint(path: "https://jsonplaceholder.typicode.com/posts/1)",
                        method: .get)

let call = APICall<Post>(endpoint: endpoint)

call.execute(callback: { response in
    switch response {
        case .success(let post): print("POST: ", post)
        case .failure(let error): print("error: ", error)
    }
})
```

### Bonus

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

Giving you the power to create SDK like access to the endpoint
```swift
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        API.getPost(id: 1).execute(callback: { response in
            switch response {
            case .success(let post): print("POST: ", post)
            case .failure(let error): print("error: ", error)
            }
        })
    }
}

```
## Observing (polling) TBC


# Roadmap

Currently working on this project in my sparetime but I'm hoping to implement:

- Observing (watching) endpoints with a providable frequency count
- A library for testing interactions with APICall<> (APIKit aids you in adhering to SOLID/TDD concepts (
- Code generation of APIModels from swagger / JSON files (automated syncing of your SDK/Networking layer)
- An interface / object for interacting with GRPC, SmartContracts or any other networking interfaces...
- Binding to UIElements
