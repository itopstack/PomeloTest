//
//  ArticleListContentView.swift
//  PomeloTest
//
//  Created by ERX-C02G47CEQ05N on 22/2/2565 BE.
//

import SwiftUI

struct ArticleListContentView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    List(viewModel.searchArticlesResult) { article in
                        ArticleCellContentView(viewModel: ArticleCellContentView.ViewModel(article: article))
                    }
                    .refreshable {
                        await viewModel.fetchArticles()
                    }
                }
            }
            .task {
                await viewModel.fetchArticles()
            }
            .navigationTitle("Articles")
            .searchable(text: $viewModel.searchText)
        }
    }
}

struct ArticleListContentView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListContentView(viewModel: ArticleListContentView.ViewModel())
    }
}
