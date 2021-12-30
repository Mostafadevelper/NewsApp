//
//  NewsResponse.swift
//  NewsApp
//
//  Created by Mostafa on 30/12/2021.
//

import Foundation


struct NewsResponse: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [Article]?
}


// MARK: - Article
struct Article: Codable {
    var source: Source?
    var author: String?
    var title, articleDescription: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title,publishedAt
        case articleDescription = "description"
        case url, urlToImage, content
    }
}

struct Source: Codable {
    var id, name: String?
}
