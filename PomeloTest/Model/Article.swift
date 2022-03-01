//
//  Article.swift
//  PomeloTest
//
//  Created by ERX-C02G47CEQ05N on 22/2/2565 BE.
//

import Foundation

// We use optional for every property because in case some key is missing from json response, we still able to decode it

struct Metadata: Codable {
    let numberOfResults: Int?
    let articles: [Article]?
    
    private enum CodingKeys: String, CodingKey {
        case numberOfResults = "num_results"
        case articles = "results"
    }
}

struct Article: Codable, Equatable, Identifiable {
    let url: String?
    let id: Int?
    let publishedDate: String?
    let updatedDate: String?
    let section: String?
    let title: String?
    let abstract: String?
    let medias: [Media]?
    let source: String?
    
    private enum CodingKeys: String, CodingKey {
        case url
        case id
        case publishedDate = "published_date"
        case updatedDate = "updated"
        case section
        case title
        case abstract
        case medias = "media"
        case source
    }
}

struct Media: Codable, Equatable {
    let photos: [Photo]?
    let caption: String?
    
    private enum CodingKeys: String, CodingKey {
        case photos = "media-metadata"
        case caption
    }
}

struct Photo: Codable, Equatable {
    let url: String?
}
