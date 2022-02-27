//
//  ArticleDetailContentView+ViewModel.swift
//  PomeloTest
//
//  Created by ERX-C02G47CEQ05N on 26/2/2565 BE.
//

import Foundation
import SwiftUI

extension ArticleDetailContentView {
    
    class ViewModel: ObservableObject {
        
        @Published var presentShareActivity = false
        
        private let article: Article
        
        init(article: Article) {
            self.article = article
        }
        
        var articleImageUrl: URL? {
            guard let url = article.medias?.first?.photos?.last?.url else {
                return nil
            }
            return URL(string: url)
        }
        
        var imageCaption: String {
            article.medias?.first?.caption ?? ""
        }
        
        var title: String {
            article.title ?? ""
        }
        
        var detail: String {
            article.abstract ?? ""
        }
        
        func imageWidth(from screenWidth: CGFloat) -> CGFloat {
            min(screenWidth, 440)
        }
        
        func imageHeight(from screenWidth: CGFloat) -> CGFloat {
            imageWidth(from: screenWidth) * 293/440
        }
        
        var articleLink: URL? {
            guard let url = article.url else {
                return nil
            }
            return URL(string: url)
        }
        
        var articleLinkLabel: String {
            article.url ?? ""
        }
        
        var source: String {
            article.source ?? ""
        }
        
        var updatedDate: String {
            article.updatedDate ?? ""
        }
    }
}
