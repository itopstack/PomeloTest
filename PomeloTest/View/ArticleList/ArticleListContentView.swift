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
                    List {
                        ForEach(viewModel.searchSectionsResult) { section in
                            Section(section.title) {
                                ForEach(section.items) { article in
                                    NavigationLink {
                                        ArticleDetailContentView(viewModel: ArticleDetailContentView.ViewModel(article: article))
                                    } label: {
                                        ArticleCellContentView(viewModel: ArticleCellContentView.ViewModel(article: article))
                                    }
                                }
                            }
                        }
                    }
                    .refreshable {
                        await viewModel.fetchArticles()
                    }
                }
            }
            .task {
                if viewModel.isFirstLoadArticle {
                    await viewModel.fetchArticles()
                    viewModel.isFirstLoadArticle = false
                }
            }
            .navigationTitle("Popular Articles")
            .searchable(text: $viewModel.searchText)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button {
                            Task {
                                await viewModel.updatePeriod(.day)
                            }
                        } label: {
                            HStack {
                                Text("Day")
                                if viewModel.period == .day {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                        
                        Button {
                            Task {
                                await viewModel.updatePeriod(.week)
                            }
                        } label: {
                            HStack {
                                Text("Week")
                                if viewModel.period == .week {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                        
                        Button {
                            Task {
                                await viewModel.updatePeriod(.month)
                            }
                        } label: {
                            HStack {
                                Text("Month")
                                if viewModel.period == .month {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    } label: {
                        Image(systemName: "timer")
                    }
                }
            }
        }
    }
}

struct ArticleListContentView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListContentView(viewModel: ArticleListContentView.ViewModel())
    }
}
