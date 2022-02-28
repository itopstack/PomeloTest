//
//  ArticleSectionTests.swift
//  PomeloTestTests
//
//  Created by ERX-C02G47CEQ05N on 28/2/2565 BE.
//

import XCTest
@testable import PomeloTest

final class ArticleSectionTests: XCTestCase {

    func testInit() {
        // given
        let expectedTitle = "Section"
        let expectedId = expectedTitle
        let expectedItems = [ArticleCellContentView_Previews.mockArticle]
        
        // when
        let section = ArticleSection(title: expectedTitle, items: expectedItems)
        
        // then
        XCTAssertEqual(section.title, expectedTitle)
        XCTAssertEqual(section.items, expectedItems)
        XCTAssertEqual(section.id, expectedId)
    }
}
