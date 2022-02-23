//
//  NewYorkTimesArticleLoader.swift
//  PomeloTest
//
//  Created by ERX-C02G47CEQ05N on 22/2/2565 BE.
//

import Foundation

protocol NewYorkTimesArticleLoaderInterface {
    func loadArticles(from request: URLRequest, decoder: JSONDecoder) async throws -> [Article]
}

struct NewYorkTimesArticleLoader: NewYorkTimesArticleLoaderInterface {
    
    private let session: NetworkSession
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func loadArticles(from request: URLRequest, decoder: JSONDecoder) async throws -> [Article] {
        let (data, response) = try await session.data(for: request, delegate: nil)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.missingURLResponse
        }
        
        switch httpResponse.statusCode {
        case 401:
            throw NetworkError.unauthorized
        case 429:
            throw NetworkError.tooManyRequests
        case 500:
            throw NetworkError.serverError
        case 200:
            let metadata = try decoder.decode(Metadata.self, from: data)
            return metadata.articles ?? []
        default:
            throw NetworkError.unknown
        }
    }
}
