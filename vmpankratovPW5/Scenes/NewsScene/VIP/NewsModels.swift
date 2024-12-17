//
//  NewsModels.swift
//  vmpankratovPW5
//
//  Created by Tom Tim on 17.12.2024.
//

import Foundation

enum News {
    enum Load {
        struct Request {
            let rubricId: Int
            let pageIndex: Int
        }
        struct Response {
            let articles: [ArticleModel]
        }
        struct ViewModel {
            let displayArticles: [DisplayArticle]
        }
    }
}

struct DisplayArticle {
    let title: String
    let description: String
    let imageURL: URL?
}

struct ArticleModel: Decodable {
    var newsId: Int?
    var title: String?
    var announce: String?
    var img: ImageContainer?
    var requestId: String?
    
    var articleUrl: URL? {
        let requestId = requestId ?? ""
        let newsId = newsId ?? 0
        return URL(string: "https://news.myseldon.com/ru/news/index/\(newsId)?requestId=\(requestId)")
    }
}

struct ImageContainer: Decodable {
    var url: URL?
}
