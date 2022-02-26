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
        
        @Published private(set) var isLoading = false
        @Published var searchText = ""
        @Published private var articles: [Article] = []
        private(set) var period: Period = .day
        var isFirstLoadArticle = true
        
        private let articleLoader: NewYorkTimesArticleLoaderInterface

        init(articleLoader: NewYorkTimesArticleLoaderInterface = NewYorkTimesArticleLoader()) {
            self.articleLoader = articleLoader
        }
        
        var searchSectionsResult: [String: [Article]] {
            if searchText.isEmpty {
                return groupArticlesIntoSection(from: articles)
            } else {
                return groupArticlesIntoSection(from: articles)
                
//                let filteredArticles = articles.filter {
//                    let title = ($0.title ?? "").lowercased()
//                    let abstract = ($0.abstract ?? "").lowercased()
//                    let keyword = searchText.lowercased()
//                    return title.contains(keyword) || abstract.contains(keyword)
//                }
//                return groupArticlesIntoSection(from: filteredArticles)
            }
        }
        
        func fetchArticles() async {
            guard let url = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/viewed/\(period.valueInDay).json?api-key=zF125X7ymsICk7EhIvzcQrJaAVPFoUc6") else { return }
            
            isLoading = true
            
            do {
                articles = try await articleLoader.loadArticles(from: url)
            } catch {
                
            }
            
            isLoading = false
        }
        
        private func groupArticlesIntoSection(from articles: [Article]) -> [String: [Article]] {
            var sections: [String: [Article]] = [:]
            for article in articles {
                if let section = article.section, !section.isEmpty {
                    sections[section, default: []].append(article)
                } else {
                    sections["Others", default: []].append(article)
                }
            }
            
            return sections
        }
        
        func updatePeriod(_ period: Period) async {
            guard period != self.period else { return }
            self.period = period
            await fetchArticles()
        }
    }
}
