//
//  ArticleListContentView+ViewModelTests.swift
//  PomeloTestTests
//
//  Created by ERX-C02G47CEQ05N on 28/2/2565 BE.
//

import XCTest
import Combine
@testable import PomeloTest

final class ArticleListContentView_ViewModelTests: XCTestCase {

    private var sut: ArticleListContentView.ViewModel!
    private var mockLoader: MockNewYorkTimesArticleLoader!
    private var subs: Set<AnyCancellable>!
    
    @MainActor
    override func setUpWithError() throws {
        mockLoader = MockNewYorkTimesArticleLoader()
        sut = ArticleListContentView.ViewModel(articleLoader: mockLoader)
        subs = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        mockLoader = nil
        sut = nil
        subs = nil
    }
    
    @MainActor
    func testInitialValue() async {
        XCTAssertFalse(sut.isLoading)
        XCTAssertTrue(sut.searchText.isEmpty)
        XCTAssertFalse(sut.presentErrorAlert)
        XCTAssertNil(sut.errorMessage)
        XCTAssertEqual(sut.period, .day)
        XCTAssertTrue(sut.isFirstLoadArticle)
    }
    
    @MainActor
    func testFetchArticleSuccess() async {
        // given
        mockLoader.wantSuccess = true
        var isLoadingChangedHistory: [Bool] = []
        sut.$isLoading
            .dropFirst()
            .sink { value in
                isLoadingChangedHistory.append(value)
            }
            .store(in: &subs)
        
        // when
        await sut.fetchArticles()
        
        // then
        XCTAssertTrue(isLoadingChangedHistory[0])
        XCTAssertFalse(isLoadingChangedHistory[1])
        XCTAssertNil(sut.errorMessage)
        XCTAssertFalse(sut.presentErrorAlert)
        XCTAssertTrue(sut.searchText.isEmpty)
        XCTAssertEqual(sut.searchSectionsResult.count, 8)
    }
    
    @MainActor
    func testFetchArticleFail() async {
        // given
        mockLoader.wantSuccess = false
        mockLoader.error = NetworkError.unauthorized
        var isLoadingChangedHistory: [Bool] = []
        sut.$isLoading
            .dropFirst()
            .sink { value in
                isLoadingChangedHistory.append(value)
            }
            .store(in: &subs)
        
        // when
        await sut.fetchArticles()
        
        // then
        XCTAssertTrue(isLoadingChangedHistory[0])
        XCTAssertFalse(isLoadingChangedHistory[1])
        XCTAssertEqual(sut.errorMessage, mockLoader.error.localizedDescription)
        XCTAssertTrue(sut.presentErrorAlert)
    }
    
    @MainActor
    func testSearchSectionsResultEmptySearchText() async {
        // given
        mockLoader.wantSuccess = true
        sut.searchText = ""
        
        // when
        await sut.fetchArticles()
        
        // then
        XCTAssertEqual(sut.searchSectionsResult.count, 8)
    }
    
    @MainActor
    func testSearchSectionsResultWithSearchText() async {
        // given
        mockLoader.wantSuccess = true
        sut.searchText = "russian"
        
        // when
        await sut.fetchArticles()
        
        // then
        let searchResult = sut.searchSectionsResult
        XCTAssertEqual(searchResult.count, 2)
        XCTAssertEqual(searchResult[0].title, "U.S.")
        XCTAssertEqual(searchResult[0].items.count, 3)
        XCTAssertEqual(searchResult[1].title, "World")
        XCTAssertEqual(searchResult[1].items.count, 3)
    }
    
    @MainActor
    func testUpdatePeriodWithSameValue() async {
        // given
        mockLoader.wantSuccess = true
        var isLoadingChangedHistory: [Bool] = []
        sut.$isLoading
            .dropFirst()
            .sink { value in
                isLoadingChangedHistory.append(value)
            }
            .store(in: &subs)
        
        // when
        XCTAssertEqual(sut.period, .day)
        await sut.updatePeriod(.day)
        
        // then
        XCTAssertEqual(sut.period, .day)
        XCTAssertTrue(isLoadingChangedHistory.isEmpty)
    }
    
    @MainActor
    func testUpdatePeriodWithNewValue() async {
        // given
        mockLoader.wantSuccess = true
        var isLoadingChangedHistory: [Bool] = []
        sut.$isLoading
            .dropFirst()
            .sink { value in
                isLoadingChangedHistory.append(value)
            }
            .store(in: &subs)
        
        // when
        XCTAssertEqual(sut.period, .day)
        await sut.updatePeriod(.week)
        
        // then
        XCTAssertEqual(sut.period, .week)
        XCTAssertTrue(isLoadingChangedHistory[0])
        XCTAssertFalse(isLoadingChangedHistory[1])
    }
}

private final class MockNewYorkTimesArticleLoader: NewYorkTimesArticleLoaderInterface {
    
    var wantSuccess: Bool!
    var error: Error!
    
    static let mockArticles: [Article] = {
        let path = Bundle(for: ArticleListContentView_ViewModelTests.self).path(forResource: "articles", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let result = try! JSONDecoder().decode(Metadata.self, from: data)
        return result.articles ?? []
    }()
    
    func loadArticles(from url: URL) async throws -> [Article] {
        if wantSuccess {
            return MockNewYorkTimesArticleLoader.mockArticles
        } else {
            throw error
        }
    }
}
