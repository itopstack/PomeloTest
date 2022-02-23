//
//  Article.swift
//  PomeloTest
//
//  Created by ERX-C02G47CEQ05N on 22/2/2565 BE.
//

import Foundation

struct Metadata: Codable {
    let numberOfResults: Int?
    let articles: [Article]?
    
    private enum CodingKeys: String, CodingKey {
        case numberOfResults = "num_results"
        case articles = "results"
    }
}

struct Article: Codable {
    let url: String?
    let id: Int?
    let publishedDate: String?
    let updatedDate: String?
    let section: String?
    let title: String?
    let abstract: String?
    let medias: [Media]?
    
    private enum CodingKeys: String, CodingKey {
        case url
        case id
        case publishedDate = "published_date"
        case updatedDate = "updated"
        case section
        case title
        case abstract
        case medias = "media"
    }
}

struct Media: Codable {
    let photo: [Photo]?
    
    private enum CodingKeys: String, CodingKey {
        case photo = "media-metadata"
    }
}

struct Photo: Codable {
    let url: String?
}
