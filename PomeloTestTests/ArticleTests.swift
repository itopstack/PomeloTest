//
//  ArticleTests.swift
//  PomeloTestTests
//
//  Created by ERX-C02G47CEQ05N on 23/2/2565 BE.
//

import XCTest
@testable import PomeloTest

final class ArticleTests: XCTestCase {
    
    func testInitPhoto() {
        // Given
        let expectedUrl = "https://static01.nyt.com/images/2022/02/20/multimedia/20madoff/20madoff-thumbStandard.jpg"
        
        // When
        let photo = Photo(url: expectedUrl)
        
        // Then
        XCTAssertEqual(photo.url, expectedUrl)
    }
    
    func testInitMedia() {
        // Given
        let expectedPhotos = [Photo(url: "https://static01.nyt.com/images/2022/02/20/multimedia/20madoff/20madoff-thumbStandard.jpg")]
        
        // When
        let media = Media(photos: expectedPhotos)
        
        // Then
        XCTAssertEqual(media.photos, expectedPhotos)
    }
    
    func testInitArticle() {
        // Given
        let expectedUrl = "https://www.nytimes.com/2022/02/20/your-money/bernie-madoff-sister-dead.html"
        let expectedId = 100000008220223
        let expectedPublishedDate = "2022-02-20"
        let expectedUpdatedDate = "2022-02-21 22:57:50"
        let expectedSection = "Your Money"
        let expectedTitle = "Bernie Madoff’s Sister and Her Husband Are Found Dead in Florida"
        let expectedAbstract = "The authorities said it appeared to be a murder-suicide."
        let expectedMedias = [Media(photos: [Photo(url: "https://static01.nyt.com/images/2022/02/20/multimedia/20madoff/20madoff-thumbStandard.jpg")])]
        
        // When
        let article = Article(url: expectedUrl, id: expectedId, publishedDate: expectedPublishedDate, updatedDate: expectedUpdatedDate, section: expectedSection, title: expectedTitle, abstract: expectedAbstract, medias: expectedMedias)
        
        // Then
        XCTAssertEqual(article.url, expectedUrl)
        XCTAssertEqual(article.id, expectedId)
        XCTAssertEqual(article.publishedDate, expectedPublishedDate)
        XCTAssertEqual(article.updatedDate, expectedUpdatedDate)
        XCTAssertEqual(article.section, expectedSection)
        XCTAssertEqual(article.title, expectedTitle)
        XCTAssertEqual(article.abstract, expectedAbstract)
        XCTAssertEqual(article.medias, expectedMedias)
    }
    
    func testInitMetadata() {
        // Given
        let expectedNumberOfResults = 20
        let expectedArticles: [Article] = [.mock]
        
        // When
        let metadata = Metadata(numberOfResults: expectedNumberOfResults, articles: expectedArticles)
        
        // Then
        XCTAssertEqual(metadata.numberOfResults, expectedNumberOfResults)
        XCTAssertEqual(metadata.articles, expectedArticles)
    }
}

private extension Article {
    
    static let mock = Article(
        url: "https://www.nytimes.com/2022/02/20/your-money/bernie-madoff-sister-dead.html",
        id: 100000008220223,
        publishedDate: "2022-02-20",
        updatedDate: "2022-02-21 22:57:50",
        section: "Your Money",
        title: "Bernie Madoff’s Sister and Her Husband Are Found Dead in Florida",
        abstract: "The authorities said it appeared to be a murder-suicide.",
        medias: [Media(photos: [Photo(url: "https://static01.nyt.com/images/2022/02/20/multimedia/20madoff/20madoff-thumbStandard.jpg")])]
    )
}
