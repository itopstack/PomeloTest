//
//  NewYorkTimesArticleLoaderTests.swift
//  PomeloTestTests
//
//  Created by ERX-C02G47CEQ05N on 23/2/2565 BE.
//

import XCTest
@testable import PomeloTest

final class NewYorkTimesArticleLoaderTests: XCTestCase {
    
    private var sut: NewYorkTimesArticleLoader!
    private var session: URLSessionMock!
    private let url = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json")!
    
    override func setUpWithError() throws {
        session = URLSessionMock()
        sut = NewYorkTimesArticleLoader(session: session)
    }

    override func tearDownWithError() throws {
        session = nil
        sut = nil
    }
    
    func testLoadArticlesSuccess() async {
        // Given
        session.statusCode = 200
        
        do {
            // When
            let articles = try await sut.loadArticles(from: url)
            
            // Then
            XCTAssertEqual(articles.count, 1)
        } catch {
            XCTFail("Expected to success")
        }
    }
    
    func testLoadArticlesSuccessEmptyResponse() async {
        // Given
        session.statusCode = 200
        session.wantEmptyResponse = true
        
        do {
            // When
            let articles = try await sut.loadArticles(from: url)
            
            // Then
            XCTAssertTrue(articles.isEmpty)
        } catch {
            XCTFail("Expect success")
        }
    }
    
    func testLoadArticlesMissingHTTPURLResponse() async {
        // Given
        session.wantMissingHTTPURLResponse = true
        
        // When
        do {
            _ = try await sut.loadArticles(from: url)
        } catch {
            // Then
            XCTAssertEqual(error as! NetworkError, .missingHTTPURLResponse)
        }
    }
    
    func testLoadArticlesUnauthorized() async {
        // Given
        session.statusCode = 401
        
        do {
            // When
            _ = try await sut.loadArticles(from: url)
            XCTFail("Expected unauthorized")
        } catch {
            // Then
            XCTAssertEqual(error as! NetworkError, .unauthorized)
        }
    }
    
    func testLoadArticlesTooManyRequests() async {
        // Given
        session.statusCode = 429
        
        do {
            // When
            _ = try await sut.loadArticles(from: url)
            XCTFail("Expected too many requests")
        } catch {
            // Then
            XCTAssertEqual(error as! NetworkError, .tooManyRequests)
        }
    }
    
    func testLoadArticlesServerError() async {
        // Given
        session.statusCode = 500
        
        do {
            // When
            _ = try await sut.loadArticles(from: url)
            XCTFail("Expected server error")
        } catch {
            // Then
            XCTAssertEqual(error as! NetworkError, .serverError)
        }
    }
    
    func testLoadArticlesUnknownError() async {
        // Given
        session.statusCode = 999
        
        do {
            // When
            _ = try await sut.loadArticles(from: url)
            XCTFail("Expected unknown error")
        } catch {
            // Then
            XCTAssertEqual(error as! NetworkError, .unknown)
        }
    }
}

private class URLSessionMock: NetworkSession {
    
    var statusCode: Int!
    var wantEmptyResponse = false
    var wantMissingHTTPURLResponse = false
    
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        
        if wantMissingHTTPURLResponse {
            let response = URLResponse(url: URL(string: "https://example.com")!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
            return (Data(), response)
        }
        
        let data: Data
        if statusCode == 200 {
            if wantEmptyResponse {
                data = emptyArticleData
            } else {
                data = successData
            }
        } else {
            data = Data()
        }
        
        let response = HTTPURLResponse(url: URL(string: "https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json")!, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
        return (data, response)
    }
    
    private let successData = """
{
    "status": "OK",
    "copyright": "Copyright (c) 2022 The New York Times Company.  All Rights Reserved.",
    "num_results": 20,
    "results": [
        {
            "uri": "nyt://article/ae43bc28-2da5-51ae-b63f-98f6dee1b69f",
            "url": "https://www.nytimes.com/2022/02/21/health/covid-vaccine-antibodies-t-cells.html",
            "id": 100000008185476,
            "asset_id": 100000008185476,
            "source": "New York Times",
            "published_date": "2022-02-21",
            "updated": "2022-02-22 11:54:47",
            "section": "Health",
            "subsection": "",
            "nytdsection": "health",
            "adx_keywords": "Coronavirus Omicron Variant;Coronavirus (2019-nCoV);Vaccination and Immunization;Immune System;your-feed-healthcare",
            "column": null,
            "byline": "By Apoorva Mandavilli",
            "type": "Article",
            "title": "Got a Covid Booster? You Probably Won’t Need Another for a Long Time",
            "abstract": "A flurry of new studies suggests that several parts of the immune system can mount a sustained, potent response to any coronavirus variant.",
            "des_facet": [
                "Coronavirus Omicron Variant",
                "Coronavirus (2019-nCoV)",
                "Vaccination and Immunization",
                "Immune System",
                "your-feed-healthcare"
            ],
            "org_facet": [],
            "per_facet": [],
            "geo_facet": [],
            "media": [
                {
                    "type": "image",
                    "subtype": "photo",
                    "caption": "A colored transmission electron micrograph of a T cell. Antibodies are relatively easy to study, whereas analyzing immune cells requires blood, skill, special equipment and lots of time.",
                    "copyright": "Dr. Klaus Boller/Science Source",
                    "approved_for_syndication": 1,
                    "media-metadata": [
                        {
                            "url": "https://static01.nyt.com/images/2022/02/19/science/19-2nd-SUB-VIRUS-IMMUNITY-02-PRINT/09virus-immunity1-thumbStandard.jpg",
                            "format": "Standard Thumbnail",
                            "height": 75,
                            "width": 75
                        },
                        {
                            "url": "https://static01.nyt.com/images/2022/02/19/science/19-2nd-SUB-VIRUS-IMMUNITY-02-PRINT/09virus-immunity1-mediumThreeByTwo210.jpg",
                            "format": "mediumThreeByTwo210",
                            "height": 140,
                            "width": 210
                        },
                        {
                            "url": "https://static01.nyt.com/images/2022/02/19/science/19-2nd-SUB-VIRUS-IMMUNITY-02-PRINT/09virus-immunity1-mediumThreeByTwo440.jpg",
                            "format": "mediumThreeByTwo440",
                            "height": 293,
                            "width": 440
                        }
                    ]
                }
            ],
            "eta_id": 0
        }
    ]
}
""".data(using: .utf8)!
    
    private let emptyArticleData = """
{
    "status": "OK",
    "copyright": "Copyright (c) 2022 The New York Times Company.  All Rights Reserved.",
    "num_results": 20,
    "results": null
}
""".data(using: .utf8)!
}
