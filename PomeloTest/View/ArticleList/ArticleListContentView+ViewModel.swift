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
        @Published private var sections: [ArticleSection] = []
        private var articles: [Article] = []
        private(set) var period: Period = .day
        var isFirstLoadArticle = true
        
        private let articleLoader: NewYorkTimesArticleLoaderInterface

        init(articleLoader: NewYorkTimesArticleLoaderInterface = NewYorkTimesArticleLoader()) {
            self.articleLoader = articleLoader
        }
        
        var searchSectionsResult: [ArticleSection] {
            if searchText.isEmpty {
                return sections
            } else {
                let filteredArticles = articles.filter {
                    let title = ($0.title ?? "").lowercased()
                    let abstract = ($0.abstract ?? "").lowercased()
                    let keyword = searchText.lowercased()
                    return title.contains(keyword) || abstract.contains(keyword)
                }
                let filteredSections = groupArticlesIntoSection(from: filteredArticles)
                return filteredSections
            }
        }
        
        func fetchArticles() async {
            guard let url = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/viewed/\(period.valueInDay).json?api-key=zF125X7ymsICk7EhIvzcQrJaAVPFoUc6") else { return }
            
            isLoading = true
            
            do {
                let articles = try await articleLoader.loadArticles(from: url)
                self.articles = articles
                sections = groupArticlesIntoSection(from: articles)
            } catch {
                
            }
            
            isLoading = false
        }
        
        private func groupArticlesIntoSection(from articles: [Article]) -> [ArticleSection] {
            var dict: [String: [Article]] = [:]
            for article in articles {
                if let section = article.section, !section.isEmpty {
                    dict[section, default: []].append(article)
                } else {
                    dict["Others", default: []].append(article)
                }
            }
            let sortedDict = dict.sorted(by: { $0.key < $1.key })
            
            var sections: [ArticleSection] = []
            for tuple in sortedDict {
                let section = ArticleSection(title: tuple.key, items: tuple.value)
                sections.append(section)
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
