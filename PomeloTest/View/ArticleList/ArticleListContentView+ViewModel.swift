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
        @Published var searchText = ""
        
        private let articleLoader: NewYorkTimesArticleLoaderInterface

        init(articleLoader: NewYorkTimesArticleLoaderInterface = NewYorkTimesArticleLoader()) {
            self.articleLoader = articleLoader
        }
        
        var searchArticlesResult: [Article] {
            if searchText.isEmpty {
                return articles
            } else {
                return articles.filter {
                    let title = ($0.title ?? "").lowercased()
                    let abstract = ($0.abstract ?? "").lowercased()
                    let keyword = searchText.lowercased()
                    return title.contains(keyword) || abstract.contains(keyword)
                }
            }
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
