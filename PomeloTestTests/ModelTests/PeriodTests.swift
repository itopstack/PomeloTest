//
//  PeriodTests.swift
//  PomeloTestTests
//
//  Created by ERX-C02G47CEQ05N on 28/2/2565 BE.
//

import XCTest
@testable import PomeloTest

final class PeriodTests: XCTestCase {

    func testValueInDay() {
        XCTAssertEqual(1, Period.day.valueInDay)
        XCTAssertEqual(7, Period.week.valueInDay)
        XCTAssertEqual(30, Period.month.valueInDay)
    }
}
