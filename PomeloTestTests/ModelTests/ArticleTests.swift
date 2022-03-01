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
        let expectedCaption = "President Vladimir V. Putin of Russia meeting with President Donald J. Trump in June 2019."
        
        // When
        let media = Media(photos: expectedPhotos, caption: expectedCaption)
        
        // Then
        XCTAssertEqual(media.photos, expectedPhotos)
        XCTAssertEqual(media.caption, expectedCaption)
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
        let expectedMedias = [Media(photos: [Photo(url: "https://static01.nyt.com/images/2022/02/20/multimedia/20madoff/20madoff-thumbStandard.jpg")], caption: "President Vladimir V. Putin of Russia meeting with President Donald J. Trump in June 2019.")]
        let expectedSource = "New York Times"
        
        // When
        let article = Article(url: expectedUrl, id: expectedId, publishedDate: expectedPublishedDate, updatedDate: expectedUpdatedDate, section: expectedSection, title: expectedTitle, abstract: expectedAbstract, medias: expectedMedias, source: expectedSource)
        
        // Then
        XCTAssertEqual(article.url, expectedUrl)
        XCTAssertEqual(article.id, expectedId)
        XCTAssertEqual(article.publishedDate, expectedPublishedDate)
        XCTAssertEqual(article.updatedDate, expectedUpdatedDate)
        XCTAssertEqual(article.section, expectedSection)
        XCTAssertEqual(article.title, expectedTitle)
        XCTAssertEqual(article.abstract, expectedAbstract)
        XCTAssertEqual(article.medias, expectedMedias)
        XCTAssertEqual(article.source, expectedSource)
    }
    
    func testInitMetadata() {
        // Given
        let expectedNumberOfResults = 1
        let expectedArticles: [Article] = [ArticleCellContentView_Previews.mockArticle]
        
        // When
        let metadata = Metadata(numberOfResults: expectedNumberOfResults, articles: expectedArticles)
        
        // Then
        XCTAssertEqual(metadata.numberOfResults, expectedNumberOfResults)
        XCTAssertEqual(metadata.articles, expectedArticles)
    }
}
