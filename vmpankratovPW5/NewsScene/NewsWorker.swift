//
//  NewsWorker.swift
//  vmpankratovPW5
//
//  Created by Tom Tim on 17.12.2024.
//

import Foundation

final class NewsWorker {
    private let decoder: JSONDecoder = JSONDecoder()
    
    struct NewsPage: Decodable {
        enum CodingKeys: String, CodingKey {
            case news
            case requestId
        }
        
        var news: [ArticleModel]?
        var requestID: String?
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            news = try container.decodeIfPresent([ArticleModel].self, forKey: .news)
            requestID = try container.decodeIfPresent(String.self, forKey: .requestId)
            
            if let reqID = requestID, let unwrappedNesws = news {
                news = unwrappedNesws.map {
                    var newArticle = $0
                    newArticle.requestId = reqID
                    return newArticle
                }
            }
        }
    }
}
