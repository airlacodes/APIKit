//
//  DemoSpec.swift
//  APIKitTests
//
//  Created by Codeonomics on 25/06/2019.
//

import Foundation
import XCTest

@testable import APIKit

final class DemoSpec: XCTestCase {

    private var testObject: Demo?
    private var mockAPICall: MockAPICall<SomeResponse> = APICall<SomeResponse>(endpoint: .some)

    override func setUp() {
        super.setUp()
        testObject = Demo(someAPICall: mockAPICall)
    }

    func testSuccessSome() {
        testObject?.some()


        mockAPICall.triggerSucess(response: SomeResponse(someProperty: 42))


        XCTAssertEqual(testObject?.somePublicVariable, 42)
    }
}
