This framework is a work in progress and not yet ready for use.

# APIKit
Connect with an API faster

APIKit gives you an object capable of reaching a URL and decoding the response within a few lines of swift.

It utilises the the [codable](https://developer.apple.com/documentation/swift/codable) protocol to encode and decode your request / response models, [URLSession](https://developer.apple.com/documentation/foundation/urlsession) to make the request and a promise / observer to execute or consistently poll an endpoint.

## Possibilities / Aims

- Fast, quick and easy way to connect to rest api endpoints
- Create a swift SDK for your API/Platform

```swift
let requestBody = SomeModel(someProperty: "abc")
let endpoint = APIEndpoint.custom(path: "/some", method: .post)
let payload = Payload(body: requestBody, endpoint: endpoint)

let apiCall = APICall<SomeResponse>(payload: payload)

apiCall.execute { result in
    switch resut {
        case .success(let response): // do something with response
        case .failure(let error): // handle error
    }
}
```


## APICall<APIModel>


## Execute

## Observing (polling)


# Roadmap

Currently working on this project in my sparetime but I'm hoping to implement:

- Observing (watching) endpoints with a providable frequency count
- A library for testing interactions with APICall<> (APIKit aids you in adhering to SOLID/TDD concepts (
- Code generation of APIModels from swagger / JSON files (automated syncing of your SDK/Networking layer)
- An interface / object for interacting with Ethereum contracts
- Binding to UIElements (mockable for offline UI tests)
