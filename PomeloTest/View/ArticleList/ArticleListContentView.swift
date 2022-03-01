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
                    .alert("Error", isPresented: $viewModel.presentErrorAlert, actions: {
                        Button("Reload") {
                            Task {
                                await viewModel.fetchArticles()
                            }
                        }
                    }, message: {
                        Text(viewModel.errorMessage ?? "")
                    })
                    .refreshable {
                        Task {
                            await viewModel.fetchArticles()
                        }
                    }
                }
            }
            .task {
                // Prevent duplicate loading articles when go back and forth between list's view and detail's view
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
            
            // Placeholder view for ipad
            VStack(spacing: 16) {
                Text("Welcome to PomeloTest!")
                    .font(.largeTitle)
                Text("Please select a resort from the left-hand menu; swipe from the left edge to show it.")
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct ArticleListContentView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListContentView(viewModel: ArticleListContentView.ViewModel())
    }
}
