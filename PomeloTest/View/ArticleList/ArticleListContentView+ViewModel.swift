//
//  ArticleListContentView+ViewModel.swift
//  PomeloTest
//
//  Created by ERX-C02G47CEQ05N on 22/2/2565 BE.
//

import Foundation
import SwiftUI

extension ArticleListContentView {
    
    @MainActor
    class ViewModel: ObservableObject {
        
        @Published private(set) var articles: [Article] = []
        @Published private(set) var isLoading = false
        
        private let articleLoader: NewYorkTimesArticleLoaderInterface

        init(articleLoader: NewYorkTimesArticleLoaderInterface = NewYorkTimesArticleLoader()) {
            self.articleLoader = articleLoader
        }
        
        func fetchArticles() async {
            guard let url = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=zF125X7ymsICk7EhIvzcQrJaAVPFoUc6") else { return }
            
            isLoading = true
            
            do {
                articles = try await articleLoader.loadArticles(from: url)
            } catch {
                
            }
            
            isLoading = false
        }
    }
}
