//
//  ArticleCellContentView+ViewModel.swift
//  PomeloTest
//
//  Created by ERX-C02G47CEQ05N on 25/2/2565 BE.
//

import Foundation

extension ArticleCellContentView {
    
    struct ViewModel {
        let article: Article
        
        var thumbnailImageUrl: URL? {
            guard let url = article.medias?.first?.photos?.first?.url else {
                return nil
            }
            return URL(string: url)
        }
        
        var title: String {
            article.title ?? ""
        }
        
        var subtitle: String {
            article.abstract ?? ""
        }
        
        var updatedDate: String {
            article.updatedDate ?? ""
        }
    }
}
