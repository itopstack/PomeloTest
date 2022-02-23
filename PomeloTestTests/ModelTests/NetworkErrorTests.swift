//
//  NetworkErrorTests.swift
//  PomeloTestTests
//
//  Created by ERX-C02G47CEQ05N on 23/2/2565 BE.
//

import XCTest
@testable import PomeloTest

final class NetworkErrorTests: XCTestCase {

    func testInitUnauthorized() {
        // Given
        let expected = "Unauthorized, please check you api key"
        
        // When
        let error = NetworkError.unauthorized
        
        // Then
        XCTAssertEqual(error.localizedDescription, expected)
    }
    
    func testInitTooManyRequests() {
        // Given
        let expected = "You have attempted maximum number of calling api, please try again later"
        
        // When
        let error = NetworkError.tooManyRequests
        
        // Then
        XCTAssertEqual(error.localizedDescription, expected)
    }
    
    func testInitMissingURLResponse() {
        // Given
        let expected = "Missing url response"
        
        // When
        let error = NetworkError.missingURLResponse
        
        // Then
        XCTAssertEqual(error.localizedDescription, expected)
    }
    
    func testInitServerError() {
        // Given
        let expected = "Internal server error"
        
        // When
        let error = NetworkError.serverError
        
        // Then
        XCTAssertEqual(error.localizedDescription, expected)
    }
    
    func testInitUnknown() {
        // Given
        let expected = "An unknown error has occurred"
        
        // When
        let error = NetworkError.unknown
        
        // Then
        XCTAssertEqual(error.localizedDescription, expected)
    }
}
