//
//  ArticleSection.swift
//  PomeloTest
//
//  Created by ERX-C02G47CEQ05N on 27/2/2565 BE.
//

import Foundation

struct ArticleSection: Identifiable {
    var id: String {
        title
    }
    
    let title: String
    let items: [Article]
}
