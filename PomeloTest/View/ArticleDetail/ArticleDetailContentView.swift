//
//  ArticleDetailContentView.swift
//  PomeloTest
//
//  Created by ERX-C02G47CEQ05N on 26/2/2565 BE.
//

import SwiftUI

struct ArticleDetailContentView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    AsyncImage(url: viewModel.articleImageUrl) { image in
                        image
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(
                        width: viewModel.imageWidth(from: geometry.size.width),
                        height: viewModel.imageHeight(from: geometry.size.width)
                    )
                    .clipped()
                    
                    Text(viewModel.imageCaption)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text(viewModel.title)
                            .font(.headline)
                        
                        Text(viewModel.detail)
                            .font(.subheadline)
                        
                        HStack {
                            Text(viewModel.source)
                                .font(.footnote)
                                .italic()
                            
                            Spacer()
                            
                            Text(viewModel.updatedDate)
                                .font(.footnote)
                                .italic()
                        }
                        .padding(.top, 16)
                        
                        if let articleLink = viewModel.articleLink {
                            HStack(alignment: .top) {
                                Text("Link:")
                                    .font(.footnote)
                                
                                Link(destination: articleLink) {
                                    Text(viewModel.articleLinkLabel)
                                        .font(.footnote)
                                        .italic()
                                        .underline()
                                        .multilineTextAlignment(.leading)
                                }
                            }
                            .padding(.top, 16)
                        }
                    }
                    .padding()
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            viewModel.presentShareActivity = true // Show share sheet
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                        }
                        .sheet(isPresented: $viewModel.presentShareActivity) {
                            if let articleLink = viewModel.articleLink {
                                ActivityViewController(activityItems: [articleLink])
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ArticleDetailContentView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetailContentView(viewModel: ArticleDetailContentView.ViewModel(article: ArticleCellContentView_Previews.mockArticle))
    }
}
