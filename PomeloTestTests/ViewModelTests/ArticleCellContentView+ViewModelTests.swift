//
//  ArticleCellContentView+ViewModelTests.swift
//  PomeloTestTests
//
//  Created by ERX-C02G47CEQ05N on 28/2/2565 BE.
//

import XCTest
@testable import PomeloTest

final class ArticleCellContentView_ViewModelTests: XCTestCase {

    private var sut: ArticleCellContentView.ViewModel!
    
    override func setUpWithError() throws {
        sut = ArticleCellContentView.ViewModel(article: ArticleCellContentView_Previews.mockArticle)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testInit() {
        XCTAssertEqual(sut.article, ArticleCellContentView_Previews.mockArticle)
    }
    
    func testThumbnailImageUrl() {
        let expected = URL(string: "https://static01.nyt.com/images/2022/02/20/multimedia/20madoff/20madoff-thumbStandard.jpg")
        XCTAssertEqual(sut.thumbnailImageUrl, expected)
    }
    
    func testTitle() {
        let expected = "Bernie Madoff’s Sister and Her Husband Are Found Dead in Florida"
        XCTAssertEqual(sut.title, expected)
    }
    
    func testSubtitle() {
        let expected = "The authorities said it appeared to be a murder-suicide."
        XCTAssertEqual(sut.subtitle, expected)
    }
    
    func testUpdatedDate() {
        let expected = "2022-02-21 22:57:50"
        XCTAssertEqual(sut.updatedDate, expected)
    }
}
