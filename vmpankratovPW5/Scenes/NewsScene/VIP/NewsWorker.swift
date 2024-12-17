//
//  NewsWorker.swift
//  vmpankratovPW5
//
//  Created by Tom Tim on 17.12.2024.
//

import Foundation

// MARK: - NewsWorker
final class NewsWorker {
    
    // MARK: - Properties
    private let decoder: JSONDecoder = JSONDecoder()
    
    // MARK: - Nested Types
    struct NewsPage: Decodable {
        
        // MARK: - CodingKeys
        enum CodingKeys: String, CodingKey {
            case news
            case requestId
        }
        
        // MARK: - Properties
        var news: [ArticleModel]?
        var requestID: String?
        
        // MARK: - Initializer
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            news = try container.decodeIfPresent([ArticleModel].self, forKey: .news)
            requestID = try container.decodeIfPresent(String.self, forKey: .requestId)
            
            if let reqID = requestID, let unwrappedNews = news {
                news = unwrappedNews.map {
                    var newArticle = $0
                    newArticle.requestId = reqID
                    return newArticle
                }
            }
        }
    }
    
    // MARK: - Public Methods
    func fetchNews(rubric: Int, pageIndex: Int, completion: @escaping (Result<[ArticleModel], Error>) -> Void) {
        guard let url = URL(string: "https://news.myseldon.com/api/Section?rubricId=\(rubric)&pageSize=8&pageIndex=\(pageIndex)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data,
                  let newsPage = try? self.decoder.decode(NewsPage.self, from: data),
                  let articles = newsPage.news else {
                completion(.failure(NSError(domain: "Decoding error", code: 0)))
                return
            }
            completion(.success(articles))
        }.resume()
    }
}
