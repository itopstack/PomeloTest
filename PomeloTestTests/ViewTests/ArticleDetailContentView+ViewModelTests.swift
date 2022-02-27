//
//  ArticleDetailContentView+ViewModelTests.swift
//  PomeloTestTests
//
//  Created by ERX-C02G47CEQ05N on 27/2/2565 BE.
//

import XCTest
@testable import PomeloTest

final class ArticleDetailContentView_ViewModelTests: XCTestCase {

    private var sut: ArticleDetailContentView.ViewModel!
    
    override func setUpWithError() throws {
        sut = ArticleDetailContentView.ViewModel(article: ArticleCellContentView_Previews.mockArticle)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testInitialValues() {
        XCTAssertFalse(sut.presentShareActivity)
    }
    
    func testArticleImageUrl() {
        let expectedArticleImageUrl = URL(string: "https://static01.nyt.com/images/2022/02/20/multimedia/20madoff/20madoff-thumbStandard.jpg")
        
        XCTAssertEqual(sut.articleImageUrl, expectedArticleImageUrl)
    }
    
    func testImageCaption() {
        let expectedImageCaption = "President Vladimir V. Putin of Russia meeting with President Donald J. Trump in June 2019."
        
        XCTAssertEqual(sut.imageCaption, expectedImageCaption)
    }
    
    func testTitle() {
        let expectedTitle = "Bernie Madoff’s Sister and Her Husband Are Found Dead in Florida"
        
        XCTAssertEqual(sut.title, expectedTitle)
    }
    
    func testDetail() {
        let expectedDetail = "The authorities said it appeared to be a murder-suicide."
        
        XCTAssertEqual(sut.detail, expectedDetail)
    }
    
    func testImageWidth() {
        // given
        let width1: CGFloat = 375
        let width2: CGFloat = 999
        let expected1: CGFloat = 375
        let expected2: CGFloat = 440
        
        // when
        let actual1 = sut.imageWidth(from: width1)
        let actual2 = sut.imageWidth(from: width2)
        
        // then
        XCTAssertEqual(actual1, expected1)
        XCTAssertEqual(actual2, expected2)
    }
    
    func testImageHeight() {
        // given
        let width1: CGFloat = 440
        let width2: CGFloat = 999
        let expected1: CGFloat = 293
        let expected2: CGFloat = 293
        
        // when
        let actual1 = sut.imageHeight(from: width1)
        let actual2 = sut.imageHeight(from: width2)
        
        // then
        XCTAssertEqual(actual1, expected1)
        XCTAssertEqual(actual2, expected2)
    }
    
    func testArticleLink() {
        let expectedArticleLink = URL(string: "https://www.nytimes.com/2022/02/20/your-money/bernie-madoff-sister-dead.html")
        
        XCTAssertEqual(sut.articleLink, expectedArticleLink)
    }
    
    func testArticleLinkLabel() {
        let expectedArticleLinkLabel = "https://www.nytimes.com/2022/02/20/your-money/bernie-madoff-sister-dead.html"
        
        XCTAssertEqual(sut.articleLinkLabel, expectedArticleLinkLabel)
    }
    
    func testSource() {
        let expectedSource = "New York Times"
        
        XCTAssertEqual(sut.source, expectedSource)
    }
    
    func testUpdatedDate() {
        let expectedUpdatedDate = "2022-02-21 22:57:50"
        
        XCTAssertEqual(sut.updatedDate, expectedUpdatedDate)
    }
}
