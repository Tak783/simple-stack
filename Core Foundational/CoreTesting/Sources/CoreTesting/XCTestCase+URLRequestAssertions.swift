//
//  XCTestCase+URLRequestAssertions.swift
//  
//
//  Created by Tak Mazarura on 06/04/2022.
//

import Foundation
import XCTest

public extension XCTestCase {
    func assert(request: URLRequest?, urlAbsoluteString: String, httpMethod: URLRequest.HTTPMethod, file: StaticString = #file, line: UInt = #line) {
        guard let request = request else {
            XCTFail("Expected request to not be nil", file: file, line: line)
            return
        }
        XCTAssertEqual(request.httpMethod, httpMethod.rawValue, file: file, line: line)
        XCTAssertEqual(request.url?.absoluteString, urlAbsoluteString, file: file, line: line)
    }
    
    func assert(request: URLRequest, hasExpectedBearerToken token: String, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(request.value(forHTTPHeaderField: "Authorization"), "Bearer \(token)", file: file, line: line)
    }
    
    func assert(request: URLRequest, hasExpectedContentType contentType: URLRequest.ContentType, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), contentType.rawValue, file: file, line: line)
    }
}
