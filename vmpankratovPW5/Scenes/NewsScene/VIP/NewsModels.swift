//
//  NewsModels.swift
//  vmpankratovPW5
//
//  Created by Tom Tim on 17.12.2024.
//

import Foundation

// MARK: - News Namespace
enum News {
    
    // MARK: - Load
    enum Load {
        
        // MARK: - Request
        struct Request {
            let rubricId: Int
            let pageIndex: Int
        }
        
        // MARK: - Response
        struct Response {
            let articles: [ArticleModel]
        }
        
        // MARK: - ViewModel
        struct ViewModel {
            let displayArticles: [DisplayArticle]
        }
    }
}

// MARK: - DisplayArticle
struct DisplayArticle {
    let title: String
    let description: String
    let imageURL: URL?
}

// MARK: - ArticleModel
struct ArticleModel: Decodable {
    enum Constants {
        static let baseURL: String = "https://news.myseldon.com/ru/news"
    }
    
    // MARK: - Properties
    var newsId: Int?
    var title: String?
    var announce: String?
    var img: ImageContainer?
    var requestId: String?
    
    // MARK: - Computed Properties
    var articleUrl: URL? {
        let requestId = requestId ?? ""
        let newsId = newsId ?? 0
        return URL(string: "\(Constants.baseURL)/index/\(newsId)?requestId=\(requestId)")
    }
}

struct ImageContainer: Decodable {
    var url: URL?
}
