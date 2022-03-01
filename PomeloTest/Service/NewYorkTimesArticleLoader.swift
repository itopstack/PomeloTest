//
//  NewYorkTimesArticleLoader.swift
//  PomeloTest
//
//  Created by ERX-C02G47CEQ05N on 22/2/2565 BE.
//

import Foundation

protocol NewYorkTimesArticleLoaderInterface {
    func loadArticles(from url: URL) async throws -> [Article]
}

struct NewYorkTimesArticleLoader: NewYorkTimesArticleLoaderInterface {
    
    private let session: NetworkSession
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func loadArticles(from url: URL) async throws -> [Article] {
        var request = URLRequest(url: url)
        request.timeoutInterval = 10
        
        let (data, response) = try await session.data(for: request, delegate: nil)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.missingHTTPURLResponse
        }
        
        switch httpResponse.statusCode {
        case 401:
            throw NetworkError.unauthorized
        case 429:
            throw NetworkError.tooManyRequests
        case 500:
            throw NetworkError.serverError
        case 200:
            let metadata = try JSONDecoder().decode(Metadata.self, from: data)
            return metadata.articles ?? [] // In case missing 'results' key from json response we send empty article back
        default:
            throw NetworkError.unknown
        }
    }
}
