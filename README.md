This framework is a work in progress and not yet ready for use.

# APIKit
Connect with an API faster

## Possibilities / Aims

- Fast, quick and easy way to connect to rest api endpoints
- Create a swift SDK for your API/Platform
- Connect directly to a DAPI such as an Ethereum smart contract

```swift
let requestBody = SomeModel(someProperty: "abc")
let endpoint = APIEndpoint.custom(path: "/some", method: .post)
let payload = Payload(body: requestBody, endpoint: endpoint)

let apiCall = APICall<SomeResponse>(payload: payload)

apiCall.execute { response in
    print(response.someProperty)
}
```
